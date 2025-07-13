//
//  ContentView.swift
//  Mewdy
//
//  Created by Dylan Hughes on 07/07/2025.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PomodoroViewModel()

    var body: some View {
        let backgroundImage = "SummerTree"

        ZStack {
            // Background image
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Main UI stack
            VStack {
                // Clock + digital time
                HStack(alignment: .center, spacing: 10) {
                    ClockTimerView()
                        .frame(width: 120, height: 120)

                    DigitalClockView()
                        .frame(width: 200, height: 75)
                }
                .padding(.top, 50)

                // Title
                Text(viewModel.timerMode == .stopped ? "Let's Begin" :
                     viewModel.timerMode == .work ? "Productivity Time" : "Break Time")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 160)

                Spacer()

                // Timer + Buttons
                VStack(spacing: 16) {
                    Text(viewModel.formatTime())
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)

                    HStack(spacing: 20) {
                        Button(action: {
                            if viewModel.isRunning {
                                viewModel.pauseTimer()
                            } else {
                                viewModel.startTimer()
                            }
                        }) {
                            Text(buttonText(viewModel))
                                .frame(minWidth: 120)
                        }
                        .buttonStyle(.borderedProminent)

                        Button(action: {
                            viewModel.resetTimer()
                        }) {
                            Text("Reset")
                                .frame(minWidth: 100)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(24)
                .shadow(radius: 10)
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }

    private func buttonText(_ viewModel: PomodoroViewModel) -> String {
        if viewModel.isRunning {
            return "Pause"
        } else if viewModel.timerMode == .stopped {
            return "Let's Start"
        } else {
            return "Let's Resume"
        }
    }
}

#Preview {
    ContentView()
}
