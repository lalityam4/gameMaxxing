import SwiftUI

struct TimerToolView: View {
    @State private var totalSeconds: Int  = 60
    @State private var remaining:    Int  = 60
    @State private var isRunning:    Bool = false
    @State private var isDone:       Bool = false
    @State private var ticker:       Timer? = nil

    private let presets = [15, 30, 60, 90, 120, 180, 300]

    var progress: CGFloat {
        totalSeconds > 0 ? CGFloat(remaining) / CGFloat(totalSeconds) : 0
    }

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    pageHeader
                    timerDisplay
                    progressBar
                    buttonRow
                    presetsSection
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Timer")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
        .onDisappear { stopTimer() }
    }

    // MARK: - Page Header

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("⏱")
                .font(.system(size: 44))
            Text("Timer")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    // MARK: - Timer Display

    private var timerDisplay: some View {
        VStack(spacing: 10) {
            Text(timeString(remaining))
                .font(.retroMono(72))
                .foregroundStyle(isDone ? Color.retroRust : Color.retroInk)
                .contentTransition(.numericText())
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 28)
                .background(Color.retroCard)
                .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                .padding(.horizontal, 20)

            if isDone {
                Text("TIME'S UP")
                    .font(.retroMono(13))
                    .tracking(3)
                    .foregroundStyle(Color.retroRust)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    // MARK: - Progress Bar

    private var progressBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.retroBorder)
                    .frame(height: 6)
                Rectangle()
                    .fill(isDone ? Color.retroRust : Color.retroInk)
                    .frame(width: geo.size.width * progress, height: 6)
                    .animation(.linear(duration: 0.5), value: remaining)
            }
        }
        .frame(height: 6)
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }

    // MARK: - Button Row

    private var buttonRow: some View {
        HStack(spacing: 12) {
            // Reset
            Button {
                stopTimer()
                remaining = totalSeconds
                isDone = false
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 14))
                    Text("Reset")
                        .font(.retroSerif(15, weight: .semibold))
                }
                .foregroundStyle(Color.retroInk)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.retroCard)
                .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                .cornerRadius(4)
            }

            // Play / Pause
            Button {
                isRunning ? stopTimer() : startTimer()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 14))
                    Text(isRunning ? "Pause" : (isDone ? "Done" : "Start"))
                        .font(.retroSerif(15, weight: .bold))
                }
                .foregroundStyle(Color.retroCream)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(isDone ? Color.retroRust : Color.retroInk)
                .cornerRadius(4)
            }
            .disabled(isDone)

            // +30s
            Button {
                remaining = min(remaining + 30, 3600)
                totalSeconds = max(totalSeconds, remaining)
                isDone = false
            } label: {
                Text("+30s")
                    .font(.retroSerif(15, weight: .semibold))
                    .foregroundStyle(Color.retroInk)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.retroCard)
                    .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }

    // MARK: - Presets

    private var presetsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Presets")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(presets, id: \.self) { secs in
                        Button {
                            stopTimer()
                            totalSeconds = secs
                            remaining   = secs
                            isDone      = false
                        } label: {
                            Text(presetLabel(secs))
                                .font(.retroMono(12))
                                .tracking(0.5)
                                .foregroundStyle(totalSeconds == secs ? Color.retroCream : Color.retroBrown)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(totalSeconds == secs ? Color.retroInk : Color.clear)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 8)
    }

    // MARK: - Helpers

    private func startTimer() {
        isRunning = true
        ticker = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remaining > 0 {
                remaining -= 1
            } else {
                stopTimer()
                isDone = true
            }
        }
    }

    private func stopTimer() {
        isRunning = false
        ticker?.invalidate()
        ticker = nil
    }

    private func timeString(_ s: Int) -> String {
        String(format: "%d:%02d", s / 60, s % 60)
    }

    private func presetLabel(_ s: Int) -> String {
        s < 60 ? "\(s)s" : (s % 60 == 0 ? "\(s/60)m" : "\(s/60)m\(s%60)s")
    }
}

#Preview {
    NavigationStack { TimerToolView() }
}
