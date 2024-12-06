
  # 钱条 - macOS 工资计算器


[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](https://www.apple.com/macos)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![macOS](https://img.shields.io/badge/macOS-13.0%2B-brightgreen.svg)](https://www.apple.com/macos)
[![Status](https://img.shields.io/badge/status-active-success.svg)]()

<div align="center">
  <img src="icon.svg" width="128" height="128" alt="钱条图标">
  <p>一个优雅的 macOS 菜单栏应用，用于实时计算和显示牛马们工作收入。</p>
</div>

<img width="426" alt="image" src="https://github.com/user-attachments/assets/a9daebb2-642a-4a2f-a78a-1852f79bf754">

## ✨ 功能特点

### 🚀 基础功能
- 实时计算当前工作收入
- 支持自定义月薪和工作天数
- 自动计算每天、每小时、每秒的收入
- 支持设置工作时间和午休时间
- 每 5 秒自动更新收入数据

### 🎨 界面设计
- 简洁优雅的 macOS 原生界面
- 支持浅色/深色模式自适应
- 金色渐变图标设计
- 精心设计的卡片式布局
- 清晰的数据展示格式

### ⚙️ 系统集成
- 菜单栏实时显示收入状态
- 支持开机自动启动
- 可选择隐藏程序坞图标（在状态栏加载后生效）
- 支持 Esc 键快速隐藏主界面
- 移除了默认的应用菜单
- 注册为财务类应用（LSApplicationCategoryType: finance）

### 📊 数据显示
- 每个月工作天数统计
- 每天收入计算
- 每天工作时长统计
- 当前实时收入
- 每秒收入精确计算

## 🛠 技术实现

### 🏗 核心架构
- 使用 SwiftUI 构建现代化界面
- 采用 MVVM 架构模式
- 使用单例模式管理设置
- 响应式数据更新

### 💾 数据持久化
- 使用 UserDefaults 存储所有设置
- 包括工作时间、工资信息等
- 自动保存用户偏好设置

### 🔄 状态管理
- 使用 @Published 属性包装器实现数据绑定
- 通过 NotificationCenter 实现跨组件通信
- 使用 Combine 框架处理数据流

### ⚡️ 性能优化
1. 程序坞图标控制
   - 在状态栏图标完全加载后（延迟 0.5 秒）设置程序坞图标状态
   - 避免启动时的图标闪烁
   - 运行时通过设置面板实时切换

2. 定时器管理
   - 使用 Timer 实现 5 秒间隔的自动更新
   - 适当的定时器清理机制
   - 低资源占用的收入计算逻辑

3. 内存管理
   - 使用 weak self 避免循环引用
   - 适当的资源释放机制

## 🔧 开发环境
- macOS 13.0+
- Swift 5.9
- Xcode 15.0+

## 📦 构建说明
1. 克隆项目到本地
```bash
git clone https://github.com/achordchan/qiantiao.git
cd qiantiao
```

2. 使用 Xcode 打开项目
3. 选择目标设备为 macOS
4. 构建并运行项目

## 📀 打包发布
使用提供的 `create-dmg.sh` 脚本创建 DMG 安装包：
```bash
chmod +x create-dmg.sh
./create-dmg.sh
```

## ⚠️ 注意事项
- 应用需要 macOS 13.0 或更高版本
- 首次启动时需要授予必要的系统权限
- 建议在 System Preferences > Security & Privacy 中允许自动启动

## 🚀 未来计划
- [ ] 支持多种货币单位
- [ ] 添加数据导出功能
- [ ] 支持自定义工资计算规则
- [ ] 添加加班费计算功能
- [ ] 支持节假日特殊计算

## 🤝 贡献指南
欢迎提交 Issue 和 Pull Request 来帮助改进项目。

## 📄 许可证
本项目采用 MIT 许可证。

## 🙏 其他
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) - 用于构建用户界面
- [Combine](https://developer.apple.com/documentation/combine) - 用于处理异步事件
- [ServiceManagement](https://developer.apple.com/documentation/servicemanagement) - 用于实现开机自启动
