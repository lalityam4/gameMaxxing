import SwiftUI

struct DiceRollerView: View {
    @State private var diceCount: Int    = 2
    @State private var diceSides: Int    = 6
    @State private var results:   [Int]  = []
    @State private var isRolling: Bool   = false

    let sideOptions = [4, 6, 8, 10, 12, 20, 100]

    var total: Int { results.reduce(0, +) }

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    pageHeader
                    configSection
                    rollButton
                    if !results.isEmpty { resultsSection }
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Dice Roller")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
    }

    // MARK: - Page Header

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("🎲")
                .font(.system(size: 44))
            Text("Dice Roller")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("Configure your dice and roll.")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    // MARK: - Config

    private var configSection: some View {
        VStack(spacing: 0) {
            // Dice count row
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("NUMBER OF DICE")
                        .font(.retroMono(10))
                        .tracking(1.5)
                        .foregroundStyle(Color.retroBrown)
                    Text("\(diceCount) \(diceCount == 1 ? "die" : "dice")")
                        .font(.retroSerif(17, weight: .semibold))
                        .foregroundStyle(Color.retroInk)
                }
                Spacer()
                HStack(spacing: 0) {
                    Button {
                        if diceCount > 1 { diceCount -= 1 }
                    } label: {
                        Text("−")
                            .font(.retroSerif(20, weight: .semibold))
                            .foregroundStyle(diceCount > 1 ? Color.retroInk : Color.retroBorder)
                            .frame(width: 44, height: 44)
                            .background(Color.retroCard)
                            .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    }
                    .disabled(diceCount <= 1)

                    Text("\(diceCount)")
                        .font(.retroMono(18))
                        .foregroundStyle(Color.retroInk)
                        .frame(width: 44, height: 44)
                        .overlay(
                            Rectangle()
                                .stroke(Color.retroBorder, lineWidth: 1)
                                .padding(.horizontal, -1)
                        )
                        .contentTransition(.numericText())

                    Button {
                        if diceCount < 10 { diceCount += 1 }
                    } label: {
                        Text("+")
                            .font(.retroSerif(20, weight: .semibold))
                            .foregroundStyle(diceCount < 10 ? Color.retroRust : Color.retroBorder)
                            .frame(width: 44, height: 44)
                            .background(Color.retroCard)
                            .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    }
                    .disabled(diceCount >= 10)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .overlay(alignment: .bottom) {
                Rectangle().fill(Color.retroBorder).frame(height: 1)
                    .padding(.horizontal, 20)
            }

            // Dice type row
            VStack(alignment: .leading, spacing: 10) {
                Text("DICE TYPE")
                    .font(.retroMono(10))
                    .tracking(1.5)
                    .foregroundStyle(Color.retroBrown)
                    .padding(.horizontal, 20)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(sideOptions, id: \.self) { sides in
                            Button {
                                diceSides = sides
                            } label: {
                                Text("d\(sides)")
                                    .font(.retroMono(13))
                                    .tracking(0.5)
                                    .foregroundStyle(diceSides == sides ? Color.retroCream : Color.retroBrown)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 10)
                                    .background(diceSides == sides ? Color.retroInk : Color.clear)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 16)
            .overlay(alignment: .bottom) {
                Rectangle().fill(Color.retroBorder).frame(height: 1)
                    .padding(.horizontal, 20)
            }
        }
    }

    // MARK: - Roll Button

    private var rollButton: some View {
        Button {
            roll()
        } label: {
            Text(isRolling ? "Rolling…" : "Roll \(diceCount)d\(diceSides) →")
                .font(.retroSerif(17, weight: .bold))
                .foregroundStyle(Color.retroCream)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(isRolling ? Color.retroBrown.opacity(0.5) : Color.retroInk)
                .cornerRadius(4)
        }
        .disabled(isRolling)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }

    // MARK: - Results

    private var resultsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: results.count > 1 ? "Results — total: \(total)" : "Result")

            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)

            let cols = min(results.count, 5)
            let columns = Array(repeating: GridItem(.flexible(), spacing: 1), count: cols)

            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(Array(results.enumerated()), id: \.offset) { _, value in
                    RetroSingleDie(value: value, sides: diceSides)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            if results.count > 1 {
                HStack {
                    Text("TOTAL")
                        .font(.retroMono(10))
                        .tracking(2)
                        .foregroundStyle(Color.retroBrown)
                    Spacer()
                    Text("\(total)")
                        .font(.retroSerif(28, weight: .bold))
                        .foregroundStyle(Color.retroInk)
                        .contentTransition(.numericText())
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(alignment: .top) {
                    Rectangle().fill(Color.retroBorder).frame(height: 1)
                        .padding(.horizontal, 20)
                        .padding(.top, 0)
                }
                .padding(.top, 12)
            }
        }
        .padding(.top, 16)
    }

    // MARK: - Roll Logic

    private func roll() {
        isRolling = true
        var flashes = 0
        let total = Int.random(in: 8...12)
        Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { t in
            results = (0..<diceCount).map { _ in Int.random(in: 1...diceSides) }
            flashes += 1
            if flashes >= total {
                t.invalidate()
                isRolling = false
            }
        }
    }
}

struct RetroSingleDie: View {
    let value: Int
    let sides: Int

    var isMax: Bool { value == sides }

    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.retroSerif(32, weight: .bold))
                .foregroundStyle(isMax ? Color.retroRust : Color.retroInk)
                .contentTransition(.numericText())
            Text("d\(sides)")
                .font(.retroMono(9))
                .tracking(1)
                .foregroundStyle(Color.retroBrown)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(isMax ? Color.retroCard : Color.retroCream)
        .overlay(Rectangle().stroke(
            isMax ? Color.retroRust : Color.retroBorder,
            lineWidth: isMax ? 2 : 1
        ))
    }
}

#Preview {
    NavigationStack { DiceRollerView() }
}
