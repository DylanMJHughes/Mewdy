//
//  PomodoroViewModel.swift
//  Mewdy
//
//  Created by Dylan Hughes on 07/07/2025.
//

import Foundation
import Combine

class PomodoroViewModel: ObservableObject {
    enum TimerMode {
        case work, breakTime, stopped
    }

    @Published var timeRemaining = 1500 // 25 minutes
    @Published var timerMode: TimerMode = .stopped
    @Published var isRunning = false

    private var timer: Timer?

    func startTimer() {
        isRunning = true
        timerMode = .work
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.tick()
        }
    }

    func pauseTimer() {
        timer?.invalidate()
        isRunning = false
    }

    func resetTimer() {
        timer?.invalidate()
        timeRemaining = 1500
        timerMode = .stopped
        isRunning = false
    }

    private func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer?.invalidate()
            switch timerMode {
            case .work:
                timeRemaining = 300 // 5-minute break
                timerMode = .breakTime
                startTimer()
            case .breakTime:
                timeRemaining = 1500
                timerMode = .work
                startTimer()
            case .stopped:
                break
            }
        }
    }

    func formatTime() -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
