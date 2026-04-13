import SwiftUI

struct RandomNumberView: View {
    @State private var minText: String = "1"
    @State private var maxText: String = "100"
    @State private var result: Int? = nil
    @State private var history: [(value: Int, min: Int, max: Int)] = []

    private var minVal: Int? { Int(minText) }
    private var maxVal: Int? { Int(maxText) }

    private var canRoll: Bool {
        guard let lo = minVal, let hi = maxVal else { return false }
        return lo <= hi
    }

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    pageHeader
                    rangeSection
                    rollButton
                    resultBox
                    if !history.isEmpty {
                        historySection
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Random Number")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
    }

    // MARK: - Page Header

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("🔢")
                .font(.system(size: 44))
            Text("Random Number")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("Pick a number between any range.")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    // MARK: - Range Section

    private var rangeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            RetroSectionHeader(title: "Range")

            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("MIN")
                        .font(.retroMono(10))
                        .tracking(1.5)
                        .foregroundStyle(Color.retroBrown)
                    TextField("1", text: $minText)
                        .font(.retroSerif(17))
                        .foregroundStyle(Color.retroInk)
                        .tint(Color.retroRust)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(Color.retroCard)
                        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                }

                Text("—")
                    .font(.retroSerif(20))
                    .foregroundStyle(Color.retroBrown)
                    .padding(.top, 20)

                VStack(alignment: .leading, spacing: 4) {
                    Text("MAX")
                        .font(.retroMono(10))
                        .tracking(1.5)
                        .foregroundStyle(Color.retroBrown)
                    TextField("100", text: $maxText)
                        .font(.retroSerif(17))
                        .foregroundStyle(Color.retroInk)
                        .tint(Color.retroRust)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(Color.retroCard)
                        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                }
            }
            .padding(.horizontal, 20)

            if let lo = minVal, let hi = maxVal, lo > hi {
                Text("Min must be less than or equal to max.")
                    .font(.retroMono(10))
                    .tracking(0.5)
                    .foregroundStyle(Color.retroRust)
                    .padding(.horizontal, 20)
            }
        }
    }

    // MARK: - Roll Button

    private var rollButton: some View {
        Button {
            rollNumber()
        } label: {
            Text("Roll →")
                .font(.retroSerif(17, weight: .bold))
                .foregroundStyle(Color.retroCream)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(canRoll ? Color.retroInk : Color.retroBrown.opacity(0.4))
                .cornerRadius(4)
        }
        .disabled(!canRoll)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }

    // MARK: - Result Box

    private var resultBox: some View {
        VStack(spacing: 0) {
            RetroSectionHeader(title: "Result")

            HStack {
                Spacer()
                ZStack {
                    Color.retroCard
                    if let n = result {
                        Text("\(n)")
                            .font(.retroSerif(72, weight: .bold))
                            .foregroundStyle(Color.retroRust)
                            .contentTransition(.numericText())
                    } else {
                        Text("—")
                            .font(.retroSerif(72, weight: .bold))
                            .foregroundStyle(Color.retroBrown)
                    }
                }
                .frame(width: 180, height: 180)
                .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 2))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
        }
    }

    // MARK: - History Section

    private var historySection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "History")

            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)

            ForEach(Array(history.reversed().enumerated()), id: \.offset) { idx, entry in
                HStack(spacing: 0) {
                    Text("\(entry.value)")
                        .font(.retroSerif(15, weight: .semibold))
                        .foregroundStyle(Color.retroInk)

                    Spacer()

                    Text("[\(entry.min)–\(entry.max)]")
                        .font(.retroMono(11))
                        .foregroundStyle(Color.retroBrown)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 13)
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Color.retroBorder).frame(height: 1)
                        .padding(.horizontal, 20)
                }
            }

            Button {
                history = []
                result = nil
            } label: {
                Text("Clear History")
                    .font(.retroMono(11))
                    .tracking(0.5)
                    .foregroundStyle(Color.retroBrown)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .padding(.top, 8)
    }

    // MARK: - Actions

    private func rollNumber() {
        guard let lo = minVal, let hi = maxVal, lo <= hi else { return }
        let rolled = Int.random(in: lo...hi)
        result = rolled
        history.append((value: rolled, min: lo, max: hi))
    }
}

#Preview {
    NavigationStack { RandomNumberView() }
}
