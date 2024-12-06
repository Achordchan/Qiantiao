import SwiftUI

struct GithubIcon: View {
    var body: some View {
        // GitHub SVG 图标
        Path { path in
            path.move(to: CGPoint(x: 12, y: 0))
            path.addCurve(to: CGPoint(x: 0, y: 12), control1: CGPoint(x: 5.373, y: 0), control2: CGPoint(x: 0, y: 5.373))
            path.addCurve(to: CGPoint(x: 12, y: 24), control1: CGPoint(x: 0, y: 18.627), control2: CGPoint(x: 5.373, y: 24))
            path.addCurve(to: CGPoint(x: 24, y: 12), control1: CGPoint(x: 18.627, y: 24), control2: CGPoint(x: 24, y: 18.627))
            path.addCurve(to: CGPoint(x: 12, y: 0), control1: CGPoint(x: 24, y: 5.373), control2: CGPoint(x: 18.627, y: 0))
            path.closeSubpath()
            
            path.move(to: CGPoint(x: 12, y: 2.4))
            path.addLine(to: CGPoint(x: 12, y: 2.4))
            path.addCurve(to: CGPoint(x: 2.4, y: 12), control1: CGPoint(x: 6.697, y: 2.4), control2: CGPoint(x: 2.4, y: 6.697))
            path.addCurve(to: CGPoint(x: 5.37, y: 19.19), control1: CGPoint(x: 2.4, y: 15.474), control2: CGPoint(x: 3.517, y: 17.71))
            path.addCurve(to: CGPoint(x: 6.12, y: 18.56), control1: CGPoint(x: 5.577, y: 19.288), control2: CGPoint(x: 6.12, y: 19.044))
            path.addLine(to: CGPoint(x: 6.12, y: 16.88))
            path.addCurve(to: CGPoint(x: 4.8, y: 16.4), control1: CGPoint(x: 5.467, y: 16.88), control2: CGPoint(x: 4.8, y: 16.4))
            path.addCurve(to: CGPoint(x: 4.32, y: 15.44), control1: CGPoint(x: 4.32, y: 16.16), control2: CGPoint(x: 4.32, y: 15.92))
            path.addCurve(to: CGPoint(x: 4.8, y: 14.72), control1: CGPoint(x: 4.32, y: 14.96), control2: CGPoint(x: 4.56, y: 14.72))
            path.addCurve(to: CGPoint(x: 5.76, y: 15.2), control1: CGPoint(x: 5.28, y: 14.72), control2: CGPoint(x: 5.76, y: 14.96))
            path.addLine(to: CGPoint(x: 5.76, y: 15.2))
            path.addCurve(to: CGPoint(x: 7.2, y: 16.88), control1: CGPoint(x: 6.24, y: 15.68), control2: CGPoint(x: 6.72, y: 16.4))
            path.addCurve(to: CGPoint(x: 7.68, y: 16.4), control1: CGPoint(x: 7.44, y: 16.64), control2: CGPoint(x: 7.68, y: 16.4))
            path.addLine(to: CGPoint(x: 7.68, y: 14.72))
            path.addCurve(to: CGPoint(x: 7.2, y: 13.76), control1: CGPoint(x: 7.68, y: 14.24), control2: CGPoint(x: 7.44, y: 13.76))
            path.addLine(to: CGPoint(x: 6.72, y: 13.76))
            path.addCurve(to: CGPoint(x: 4.8, y: 11.84), control1: CGPoint(x: 5.76, y: 13.76), control2: CGPoint(x: 4.8, y: 12.8))
            path.addCurve(to: CGPoint(x: 5.76, y: 9.44), control1: CGPoint(x: 4.8, y: 10.88), control2: CGPoint(x: 5.28, y: 9.92))
            path.addCurve(to: CGPoint(x: 5.76, y: 8.48), control1: CGPoint(x: 5.76, y: 9.2), control2: CGPoint(x: 5.76, y: 8.72))
            path.addCurve(to: CGPoint(x: 6.72, y: 7.52), control1: CGPoint(x: 6, y: 8), control2: CGPoint(x: 6.48, y: 7.52))
            path.addLine(to: CGPoint(x: 17.28, y: 7.52))
            path.addCurve(to: CGPoint(x: 18.24, y: 8.48), control1: CGPoint(x: 17.52, y: 7.52), control2: CGPoint(x: 18, y: 8))
            path.addCurve(to: CGPoint(x: 18.24, y: 9.44), control1: CGPoint(x: 18.24, y: 8.72), control2: CGPoint(x: 18.24, y: 9.2))
            path.addCurve(to: CGPoint(x: 19.2, y: 11.84), control1: CGPoint(x: 18.72, y: 9.92), control2: CGPoint(x: 19.2, y: 10.88))
            path.addCurve(to: CGPoint(x: 17.28, y: 13.76), control1: CGPoint(x: 19.2, y: 12.8), control2: CGPoint(x: 18.24, y: 13.76))
            path.addLine(to: CGPoint(x: 16.8, y: 13.76))
            path.addCurve(to: CGPoint(x: 16.32, y: 14.72), control1: CGPoint(x: 16.56, y: 13.76), control2: CGPoint(x: 16.32, y: 14.24))
            path.addLine(to: CGPoint(x: 16.32, y: 16.88))
            path.addCurve(to: CGPoint(x: 16.8, y: 17.84), control1: CGPoint(x: 16.32, y: 17.36), control2: CGPoint(x: 16.56, y: 17.84))
            path.addCurve(to: CGPoint(x: 18.63, y: 19.19), control1: CGPoint(x: 17.28, y: 17.84), control2: CGPoint(x: 18.63, y: 18.71))
            path.addCurve(to: CGPoint(x: 21.6, y: 12), control1: CGPoint(x: 20.483, y: 17.71), control2: CGPoint(x: 21.6, y: 15.474))
            path.addCurve(to: CGPoint(x: 12, y: 2.4), control1: CGPoint(x: 21.6, y: 6.697), control2: CGPoint(x: 17.303, y: 2.4))
        }
        .fill(Color.black)
        .frame(width: 24, height: 24)
    }
}

struct AuthorView: View {
    var body: some View {
        VStack(spacing: 25) {
            // 作者头像/Logo
            Image(systemName: "dollarsign.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(.linearGradient(colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(color: .yellow.opacity(0.3), radius: 10, x: 0, y: 5)
                .padding(.top, 30)
            
            // 作者信息
            VStack(spacing: 20) {
                Text("Achord")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                
                VStack(spacing: 12) {
                    Button(action: {
                        if let url = URL(string: "mailto:achordchan@gmail.com") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.blue)
                            Text("achordchan@gmail.com")
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        if let url = URL(string: "https://github.com/Achordchan") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 10) {
                            GithubIcon()
                                .frame(width: 16, height: 16)
                            Text("GitHub")
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            Spacer()
            
            Text("© 2024 www.achord.help. All rights reserved.")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }
        .frame(width: 300, height: 400)
        .background(
            ZStack {
                Color(NSColor.windowBackgroundColor)
                
                // 背景装饰
                Circle()
                    .fill(Color.yellow.opacity(0.1))
                    .frame(width: 200, height: 200)
                    .offset(x: -100, y: -100)
                
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 150, height: 150)
                    .offset(x: 120, y: 160)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
    }
} 