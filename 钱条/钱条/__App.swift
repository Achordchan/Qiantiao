//
//  __App.swift
//  钱条
//
//  Created by A chord on 2024/12/6.
//

import SwiftUI

struct QianTiaoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
        .commands {
            // 移除所有默认菜单
            CommandGroup(replacing: .appInfo) {}
            CommandGroup(replacing: .systemServices) {}
            CommandGroup(replacing: .newItem) {}
            CommandGroup(replacing: .pasteboard) {}
            CommandGroup(replacing: .undoRedo) {}
            CommandGroup(replacing: .help) {}
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover: NSPopover?
    private var settings = SalarySettings.shared
    private var timer: Timer?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusItem()
        setupPopover()
        setupNotifications()
        
        // 启动时立即计算一次
        calculateAndUpdateEarnings()
        
        // 设置定时器，每5���更新一次
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.calculateAndUpdateEarnings()
        }
    }
    
    private func setupStatusItem() {
        // 确保只创建一个状态栏项
        if statusItem == nil {
            statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
            if let button = statusItem?.button {
                button.action = #selector(togglePopover)
                updateMenuBarStatus()
                
                // 在状态栏图标完全设置后，延迟一小段时间再设置程序坞图标状态
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let hideDockIcon = UserDefaults.standard.bool(forKey: "hideDockIcon")
                    NSApplication.shared.setActivationPolicy(hideDockIcon ? .accessory : .regular)
                }
            }
        }
    }
    
    private func setupPopover() {
        popover = NSPopover()
        popover?.contentSize = NSSize(width: 400, height: 600)
        popover?.behavior = .transient
        popover?.contentViewController = NSHostingController(rootView: ContentView())
    }
    
    private func setupNotifications() {
        // 移除可能存在的旧观察者
        NotificationCenter.default.removeObserver(self)
        // 添加新的观察者
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAmountUpdate(_:)),
            name: Notification.Name("UpdateMenuBarAmount"),
            object: nil
        )
    }
    
    @objc func handleAmountUpdate(_ notification: Notification) {
        if let amount = notification.userInfo?["amount"] as? Double {
            updateMenuBarAmount(amount)
        }
    }
    
    @objc func togglePopover() {
        if let button = statusItem?.button {
            if let popover = popover {
                if popover.isShown {
                    popover.performClose(nil)
                } else {
                    popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
                }
            }
        }
    }
    
    private func updateMenuBarAmount(_ amount: Double) {
        if let button = statusItem?.button {
            let calendar = Calendar.current
            let now = Date()
            let hour = calendar.component(.hour, from: now)
            let minute = calendar.component(.minute, from: now)
            let currentMinutes = hour * 60 + minute
            
            // 获取各个时间点
            let workStartHour = calendar.component(.hour, from: settings.workStartTime)
            let workStartMinute = calendar.component(.minute, from: settings.workStartTime)
            let workStartMinutes = workStartHour * 60 + workStartMinute
            
            let workEndHour = calendar.component(.hour, from: settings.workEndTime)
            let workEndMinute = calendar.component(.minute, from: settings.workEndTime)
            let workEndMinutes = workEndHour * 60 + workEndMinute
            
            let lunchStartHour = calendar.component(.hour, from: settings.lunchStartTime)
            let lunchStartMinute = calendar.component(.minute, from: settings.lunchStartTime)
            let lunchStartMinutes = lunchStartHour * 60 + lunchStartMinute
            
            let lunchEndHour = calendar.component(.hour, from: settings.lunchEndTime)
            let lunchEndMinute = calendar.component(.minute, from: settings.lunchEndTime)
            let lunchEndMinutes = lunchEndHour * 60 + lunchEndMinute
            
            let attributedString = NSMutableAttributedString()
            let attributes: [NSAttributedString.Key: Any] = [
                .font: NSFont.monospacedDigitSystemFont(ofSize: 12, weight: .regular)
            ]
            
            // 根据不同时间段显示不同内容
            if currentMinutes >= lunchStartMinutes && currentMinutes <= lunchEndMinutes {
                // 午休时间
                attributedString.append(NSAttributedString(string: "吃饭吧，这会儿工作属于无偿奉献", attributes: attributes))
            } else if currentMinutes >= workStartMinutes && currentMinutes <= workEndMinutes {
                // 工作时间
                let amountString = String(format: "已赚¥%.2f窝囊费", amount)
                attributedString.append(NSAttributedString(string: amountString, attributes: attributes))
            } else {
                // 非工作时间
                attributedString.append(NSAttributedString(string: "今天又是加量不加价的一天", attributes: attributes))
            }
            
            button.attributedTitle = attributedString
        }
    }
    
    private func updateMenuBarStatus() {
        updateMenuBarAmount(0)
    }
    
    private func calculateAndUpdateEarnings() {
        let earnings = settings.calculateCurrentEarnings()
        updateMenuBarAmount(earnings)
        // 通知 ContentView 更新显示
        NotificationCenter.default.post(
            name: Notification.Name("UpdateMenuBarAmount"),
            object: nil,
            userInfo: ["amount": earnings]
        )
    }
    
    deinit {
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
}
