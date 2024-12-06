//
//  ContentView.swift
//  钱条
//
//  Created by A chord on 2024/12/6.
//

import SwiftUI
import AppKit

// 导入 LaunchAtLogin 类
@_exported import class ServiceManagement.SMAppService

// 通用卡片样式
struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(NSColor.controlBackgroundColor))
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
            )
    }
}

// 时间设置卡片组件
struct TimeSettingCard: View {
    let title: String
    @Binding var startTime: Date
    @Binding var endTime: Date
    
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .foregroundColor(.secondary)
                .frame(width: 60, alignment: .leading)
            DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .frame(width: 85)
            Text("至")
                .foregroundColor(.secondary)
            DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .frame(width: 85)
        }
    }
}

// 统计信息行组件
struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .foregroundColor(.secondary)
                .frame(width: 90, alignment: .leading)
            Text(value)
                .font(.system(.body, design: .monospaced))
                .frame(width: 100, alignment: .trailing)
        }
    }
}

struct ContentView: View {
    @StateObject private var settings = SalarySettings.shared
    @State private var earnedToday: Double = 0.0
    @State private var showingAuthorInfo = false
    @AppStorage("launchAtLogin") private var launchAtLogin = false
    
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // 背景渐变
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(NSColor.windowBackgroundColor).opacity(0.95),
                    Color(NSColor.windowBackgroundColor)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 12) {
                // 标题部分
                VStack(spacing: 10) {
                    Image(systemName: "dollarsign.circle.fill")
                        .resizable()
                        .frame(width: 56, height: 56)
                        .foregroundStyle(.linearGradient(
                            colors: [Color(hex: "FFD700"), Color(hex: "FFA500")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .shadow(color: Color(hex: "FFA500").opacity(0.3), radius: 8, x: 0, y: 4)
                        .padding(.bottom, 2)
                    
                    Text("钱条")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(NSColor.labelColor))
                    
                    Text("挣钱的进度条，就是老板给我的欠条")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 5)
                
                // 设置卡片
                VStack(spacing: 12) {
                    Group {
                        TimeSettingCard(title: "上班", startTime: $settings.workStartTime, endTime: $settings.workEndTime)
                        TimeSettingCard(title: "午休", startTime: $settings.lunchStartTime, endTime: $settings.lunchEndTime)
                    }
                    
                    VStack(spacing: 12) {
                        HStack(spacing: 8) {
                            Text("月薪")
                                .foregroundColor(.secondary)
                                .frame(width: 60, alignment: .leading)
                            TextField("", value: $settings.monthlySalary, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 85)
                            Text("人民币")
                                .foregroundColor(.secondary)
                        }
                        
                        HStack(spacing: 8) {
                            Text("实际工作")
                                .foregroundColor(.secondary)
                                .frame(width: 60, alignment: .leading)
                            TextField("", value: $settings.workDaysPerMonth, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 85)
                            Text("天/月")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .modifier(CardBackground())
                
                // 统计信息卡片
                VStack(alignment: .center, spacing: 10) {
                    InfoRow(title: "每个月工作", value: "\(settings.workDaysPerMonth)天")
                    InfoRow(title: "每天收入", value: String(format: "%.2f元", settings.dailySalary))
                    InfoRow(title: "每天工作时长", value: String(format: "%.1f小时", settings.dailyWorkHours))
                    InfoRow(title: "当前收入", value: String(format: "%.1f元", earnedToday))
                    InfoRow(title: "每秒收入", value: String(format: "%.6f元", settings.secondRate))
                }
                .modifier(CardBackground())
                
                Spacer()
                
                // 底部设置
                VStack(spacing: 8) {
                    Divider()
                        .padding(.horizontal, -10)
                    
                    Toggle(isOn: Binding(
                        get: { launchAtLogin },
                        set: { newValue in
                            launchAtLogin = newValue
                            do {
                                if newValue {
                                    if SMAppService.mainApp.status == .enabled {
                                        try? SMAppService.mainApp.unregister()
                                    }
                                    try SMAppService.mainApp.register()
                                } else {
                                    try SMAppService.mainApp.unregister()
                                }
                            } catch {
                                print("Failed to \(newValue ? "enable" : "disable") launch at login: \(error)")
                            }
                        }
                    )) {
                        Text("开机自动启动")
                            .foregroundColor(.secondary)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color(hex: "007AFF")))
                    
                    Toggle(isOn: $settings.hideDockIcon) {
                        Text("隐藏程序坞图标")
                            .foregroundColor(.secondary)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color(hex: "007AFF")))
                    
                    // 底部按钮栏
                    HStack {
                        Button(action: {
                            showingAuthorInfo.toggle()
                        }) {
                            Text("关于作者")
                                .foregroundColor(Color(hex: "007AFF"))
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                        
                        Text("Esc 隐藏主界面")
                            .foregroundColor(.secondary)
                    }
                    .font(.caption)
                }
                .padding(.horizontal)
            }
            .padding(10)
            
            // 作者信息弹窗
            if showingAuthorInfo {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showingAuthorInfo.toggle()
                    }
                
                AuthorView()
                    .transition(.scale)
            }
        }
        .frame(width: 400, height: 670)
        .onReceive(timer) { _ in
            checkAndUpdateEarnings()
        }
        .onChange(of: settings.monthlySalary) { _, _ in updateEarnings() }
        .onChange(of: settings.workDaysPerMonth) { _, _ in updateEarnings() }
        .onChange(of: settings.workStartTime) { _, _ in updateEarnings() }
        .onChange(of: settings.workEndTime) { _, _ in updateEarnings() }
        .onChange(of: settings.lunchStartTime) { _, _ in updateEarnings() }
        .onChange(of: settings.lunchEndTime) { _, _ in updateEarnings() }
    }
    
    private func checkAndUpdateEarnings() {
        let calendar = Calendar.current
        let now = Date()
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let currentMinutes = hour * 60 + minute
        
        let workStartHour = calendar.component(.hour, from: settings.workStartTime)
        let workStartMinute = calendar.component(.minute, from: settings.workStartTime)
        let workStartMinutes = workStartHour * 60 + workStartMinute
        
        let workEndHour = calendar.component(.hour, from: settings.workEndTime)
        let workEndMinute = calendar.component(.minute, from: settings.workEndTime)
        let workEndMinutes = workEndHour * 60 + workEndMinute
        
        if currentMinutes >= workStartMinutes && currentMinutes <= workEndMinutes {
            updateEarnings()
        }
    }
    
    private func updateEarnings() {
        earnedToday = settings.calculateCurrentEarnings()
        NotificationCenter.default.post(
            name: Notification.Name("UpdateMenuBarAmount"),
            object: nil,
            userInfo: ["amount": earnedToday]
        )
    }
}

// 添加颜色扩展
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ContentView()
}
