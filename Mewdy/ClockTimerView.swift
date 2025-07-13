//
//  ClockTimerView.swift
//  Mewdy
//
//  Created by Dylan Hughes on 07/07/2025.
//
import SwiftUI

struct ClockTimerView: View {
    @State private var currentTime = Date()

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            // Clock face
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 120, height: 120)
                .shadow(radius: 5)

            // Hour markers
            ForEach(1..<13) { hour in
                Text("\(hour)")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .position(circlePoint(radius: 50, index: hour))
            }
            
            // Hour Hand
            Rectangle()
                .fill(Color.white)
                .fill(Color.white.opacity(0.8))
                .frame(width: 3, height: 30)
                    .offset(y: -15)
                    .rotationEffect(.degrees(hourAngle))

            // Minute hand
            Rectangle()
                .fill(Color.white)
                .frame(width: 2, height: 40)
                .offset(y: -20)
                .rotationEffect(.degrees(minuteAngle))

            // Second hand
            Rectangle()
                .fill(Color.white.opacity(0.6))
                .frame(width: 1, height: 50)
                .offset(y: -25)
                .rotationEffect(.degrees(secondAngle))
        }
        .onReceive(timer) { input in
            currentTime = input
        }
    }

    //  Clock hand angles
    var calendar: Calendar { Calendar.current }

    var hourAngle: Double {
        let hour = Double(calendar.component(.hour, from: currentTime) % 12)
        let minute = Double(calendar.component(.minute, from: currentTime))
        return (hour + minute / 60.0) * 30.0 // 360/12
    }

    var minuteAngle: Double {
        let minute = Double(calendar.component(.minute, from: currentTime))
        let second = Double(calendar.component(.second, from: currentTime))
        return (minute + second / 60.0) * 6.0 // 360/60
    }

    var secondAngle: Double {
        let second = Double(calendar.component(.second, from: currentTime))
        return second * 6.0 // 360/60
    }

    // Positioning text in a circle
    func circlePoint(radius: CGFloat, index: Int) -> CGPoint {
        let angle = Double(index) * (360.0 / 12.0) - 90
        let radian = angle * .pi / 180
        let centerX: CGFloat = 60
        let centerY: CGFloat = 60

        return CGPoint(
            x: centerX + radius * CGFloat(cos(radian)),
            y: centerY + radius * CGFloat(sin(radian))
        )
    }
}
