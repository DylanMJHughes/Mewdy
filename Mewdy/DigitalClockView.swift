//
//  DigitalClockView.swift
//  Mewdy
//
//  Created by Dylan Hughes on 13/07/2025.
//

import SwiftUI

struct DigitalClockView: View {
    @State private var currentTime = Date()

    private var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: currentTime)
    }

    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: currentTime)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(timeString)
                .font(.system(size: 30, weight: .bold, design: .monospaced))
                .foregroundColor(.white)

            Text(dateString)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.9))
                
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 5)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                currentTime = Date()
            }
        }
    }
}
