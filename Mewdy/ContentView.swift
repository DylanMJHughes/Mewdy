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
        // Get current season image name
        let backgroundImage = currentSeason()

        return ZStack {
            // Dynamic seasonal background
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Foreground UI
            VStack {
                // Title at top
                Text(viewModel.timerMode == .stopped ? "Let's Begin" :
                     viewModel.timerMode == .work ? "Productivity Time" : "Break Time")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 160)

                Spacer()

                // Blurry timer + controls box at bottom
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
                            Text(buttonText())
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

    // Dynamically sets the button label
    private func buttonText() -> String {
        if viewModel.isRunning {
            return "Pause"
        } else if viewModel.timerMode == .stopped {
            return "Let's Start"
        } else {
            return "Let's Resume"
        }
    }

    // Season Helper
    private func currentSeason() -> String {
        let month = Calendar.current.component(.month, from: Date())
        switch month {
        case 3...5:
            return "SpringTree"
        case 6...8:
            return "SummerTree"
        case 9...11:
            return "AutumnTree"
        default:
            return "WinterTree"
        }
    }
}

#Preview {
    ContentView()
}

// test push
