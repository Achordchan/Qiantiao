import Foundation
import Combine
import AppKit

class SalarySettings: ObservableObject {
    // 单例实例
    static let shared = SalarySettings()
    
    // UserDefaults keys
    private let workStartTimeKey = "workStartTime"
    private let workEndTimeKey = "workEndTime"
    private let lunchStartTimeKey = "lunchStartTime"
    private let lunchEndTimeKey = "lunchEndTime"
    private let monthlySalaryKey = "monthlySalary"
    private let workDaysPerMonthKey = "workDaysPerMonth"
    private let hideDockIconKey = "hideDockIcon"
    
    @Published var workStartTime: Date {
        didSet {
            saveTime(workStartTime, forKey: workStartTimeKey)
            objectWillChange.send()
        }
    }
    @Published var workEndTime: Date {
        didSet {
            saveTime(workEndTime, forKey: workEndTimeKey)
            objectWillChange.send()
        }
    }
    @Published var lunchStartTime: Date {
        didSet {
            saveTime(lunchStartTime, forKey: lunchStartTimeKey)
            objectWillChange.send()
        }
    }
    @Published var lunchEndTime: Date {
        didSet {
            saveTime(lunchEndTime, forKey: lunchEndTimeKey)
            objectWillChange.send()
        }
    }
    @Published var monthlySalary: Double {
        didSet {
            UserDefaults.standard.set(monthlySalary, forKey: monthlySalaryKey)
            objectWillChange.send()
        }
    }
    @Published var workDaysPerMonth: Int {
        didSet {
            UserDefaults.standard.set(workDaysPerMonth, forKey: workDaysPerMonthKey)
            objectWillChange.send()
        }
    }
    
    @Published var hideDockIcon: Bool {
        didSet {
            UserDefaults.standard.set(hideDockIcon, forKey: hideDockIconKey)
            objectWillChange.send()
            // 更新程序坞图标显示状态
            NSApplication.shared.setActivationPolicy(hideDockIcon ? .accessory : .regular)
        }
    }
    
    private func saveTime(_ date: Date, forKey key: String) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        UserDefaults.standard.set("\(components.hour ?? 0):\(components.minute ?? 0)", forKey: key)
    }
    
    private static func loadTime(forKey key: String, defaultHour: Int, defaultMinute: Int) -> Date {
        let calendar = Calendar.current
        if let timeString = UserDefaults.standard.string(forKey: key),
           let hour = Int(timeString.split(separator: ":")[0]),
           let minute = Int(timeString.split(separator: ":")[1]) {
            let components = DateComponents(hour: hour, minute: minute)
            return calendar.date(from: components) ?? Date()
        } else {
            let components = DateComponents(hour: defaultHour, minute: defaultMinute)
            return calendar.date(from: components) ?? Date()
        }
    }
    
    private init() {
        // 从 UserDefaults 加载保存的设置，如果没有则使用默认值
        workStartTime = SalarySettings.loadTime(forKey: workStartTimeKey, defaultHour: 8, defaultMinute: 30)
        workEndTime = SalarySettings.loadTime(forKey: workEndTimeKey, defaultHour: 18, defaultMinute: 0)
        lunchStartTime = SalarySettings.loadTime(forKey: lunchStartTimeKey, defaultHour: 12, defaultMinute: 0)
        lunchEndTime = SalarySettings.loadTime(forKey: lunchEndTimeKey, defaultHour: 13, defaultMinute: 30)
        
        let savedMonthlySalary = UserDefaults.standard.double(forKey: monthlySalaryKey)
        monthlySalary = savedMonthlySalary > 0 ? savedMonthlySalary : 10000
        
        let savedWorkDays = UserDefaults.standard.integer(forKey: workDaysPerMonthKey)
        workDaysPerMonth = savedWorkDays > 0 ? savedWorkDays : 21
        
        // 加载程序坞图标���示设置
        hideDockIcon = UserDefaults.standard.bool(forKey: hideDockIconKey)
        // 初始化时不设置程序坞图标状态，让 AppDelegate 来处理
    }
    
    // 计算每天工作时长（小时）
    var dailyWorkHours: Double {
        let workHours = Calendar.current.dateComponents([.minute], 
            from: workStartTime, to: workEndTime).minute ?? 0
        let lunchHours = Calendar.current.dateComponents([.minute], 
            from: lunchStartTime, to: lunchEndTime).minute ?? 0
        return Double(workHours - lunchHours) / 60.0
    }
    
    // 计算每天工资
    var dailySalary: Double {
        return monthlySalary / Double(workDaysPerMonth)
    }
    
    // 计算每小时工资
    var hourlyRate: Double {
        return dailySalary / dailyWorkHours
    }
    
    // 计算每秒工资
    var secondRate: Double {
        return hourlyRate / 3600
    }
    
    // 计算当前已赚取的工资
    func calculateCurrentEarnings() -> Double {
        let now = Date()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: now)
        
        // 获取今天的具体时间点
        let todayWorkStart = calendar.date(from: DateComponents(
            year: calendar.component(.year, from: today),
            month: calendar.component(.month, from: today),
            day: calendar.component(.day, from: today),
            hour: calendar.component(.hour, from: workStartTime),
            minute: calendar.component(.minute, from: workStartTime)
        )) ?? today
        
        let todayLunchStart = calendar.date(from: DateComponents(
            year: calendar.component(.year, from: today),
            month: calendar.component(.month, from: today),
            day: calendar.component(.day, from: today),
            hour: calendar.component(.hour, from: lunchStartTime),
            minute: calendar.component(.minute, from: lunchStartTime)
        )) ?? today
        
        let todayLunchEnd = calendar.date(from: DateComponents(
            year: calendar.component(.year, from: today),
            month: calendar.component(.month, from: today),
            day: calendar.component(.day, from: today),
            hour: calendar.component(.hour, from: lunchEndTime),
            minute: calendar.component(.minute, from: lunchEndTime)
        )) ?? today
        
        let todayWorkEnd = calendar.date(from: DateComponents(
            year: calendar.component(.year, from: today),
            month: calendar.component(.month, from: today),
            day: calendar.component(.day, from: today),
            hour: calendar.component(.hour, from: workEndTime),
            minute: calendar.component(.minute, from: workEndTime)
        )) ?? today
        
        // 如果不在工��间内
        if now < todayWorkStart || now > todayWorkEnd {
            return 0
        }
        
        var totalSeconds = 0.0
        
        if now < todayLunchStart {
            // 上午工作时间
            totalSeconds = now.timeIntervalSince(todayWorkStart)
        } else if now >= todayLunchStart && now <= todayLunchEnd {
            // 午休时间，只计算上午的工作时间
            totalSeconds = todayLunchStart.timeIntervalSince(todayWorkStart)
        } else {
            // 下午工作时间
            let morningSeconds = todayLunchStart.timeIntervalSince(todayWorkStart)
            let afternoonSeconds = now.timeIntervalSince(todayLunchEnd)
            totalSeconds = morningSeconds + afternoonSeconds
        }
        
        return max(0, totalSeconds * secondRate)
    }
} 