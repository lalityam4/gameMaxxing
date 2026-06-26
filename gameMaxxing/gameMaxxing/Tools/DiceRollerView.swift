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

            let cols = min(results.count, 4)
            let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: cols)

            LazyVGrid(columns: columns, spacing: 12) {
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

    private let faceSize: CGFloat = 60
    private let depth: CGFloat  = 7
    private let pipSize: CGFloat = 10

    private var faceColor: Color {
        isMax ? Color(red: 1.0, green: 0.97, blue: 0.94)
              : Color(red: 0.96, green: 0.91, blue: 0.83)
    }
    private var depthColor: Color {
        isMax ? Color(red: 0.50, green: 0.16, blue: 0.04)
              : Color(red: 0.20, green: 0.14, blue: 0.09)
    }
    private var borderColor: Color {
        isMax ? Color.retroRust : Color(red: 0.42, green: 0.30, blue: 0.20)
    }
    private var pipColor: Color {
        isMax ? Color.retroRust : Color(red: 0.11, green: 0.07, blue: 0.03)
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Right parallelogram face
            Path { p in
                p.move(to:    CGPoint(x: faceSize,         y: 0))
                p.addLine(to: CGPoint(x: faceSize + depth, y: depth))
                p.addLine(to: CGPoint(x: faceSize + depth, y: faceSize + depth))
                p.addLine(to: CGPoint(x: faceSize,         y: faceSize))
                p.closeSubpath()
            }
            .fill(depthColor)

            // Bottom parallelogram face
            Path { p in
                p.move(to:    CGPoint(x: 0,                y: faceSize))
                p.addLine(to: CGPoint(x: depth,            y: faceSize + depth))
                p.addLine(to: CGPoint(x: faceSize + depth, y: faceSize + depth))
                p.addLine(to: CGPoint(x: faceSize,         y: faceSize))
                p.closeSubpath()
            }
            .fill(depthColor.opacity(0.75))

            // Top face
            Rectangle()
                .fill(faceColor)
                .frame(width: faceSize, height: faceSize)
                .overlay(faceContent)
                .overlay(Rectangle().stroke(borderColor, lineWidth: isMax ? 2 : 1.5))
        }
        .frame(width: faceSize + depth, height: faceSize + depth)
        .frame(maxWidth: .infinity) // centre in grid cell
    }

    @ViewBuilder
    private var faceContent: some View {
        if sides == 6, value >= 1, value <= 6 {
            pipLayout
        } else {
            VStack(spacing: 2) {
                Text("\(value)")
                    .font(.retroSerif(24, weight: .bold))
                    .foregroundStyle(isMax ? Color.retroRust : Color.retroInk)
                    .contentTransition(.numericText())
                Text("d\(sides)")
                    .font(.retroMono(8))
                    .tracking(1)
                    .foregroundStyle(Color.retroBrown)
            }
        }
    }

    // Pip positions calibrated for 60×60 face
    private var pipPositions: [CGPoint] {
        let l: CGFloat = 16, r: CGFloat = 44   // left / right column
        let t: CGFloat = 14, m: CGFloat = 30, b: CGFloat = 46  // top / mid / bottom row
        switch value {
        case 1: return [CGPoint(x: 30, y: 30)]
        case 2: return [CGPoint(x: r, y: t), CGPoint(x: l, y: b)]
        case 3: return [CGPoint(x: r, y: t), CGPoint(x: 30, y: 30), CGPoint(x: l, y: b)]
        case 4: return [CGPoint(x: l, y: t), CGPoint(x: r, y: t),
                        CGPoint(x: l, y: b), CGPoint(x: r, y: b)]
        case 5: return [CGPoint(x: l, y: t), CGPoint(x: r, y: t),
                        CGPoint(x: 30, y: 30),
                        CGPoint(x: l, y: b), CGPoint(x: r, y: b)]
        case 6: return [CGPoint(x: l, y: t), CGPoint(x: r, y: t),
                        CGPoint(x: l, y: m), CGPoint(x: r, y: m),
                        CGPoint(x: l, y: b), CGPoint(x: r, y: b)]
        default: return []
        }
    }

    @ViewBuilder
    private var pipLayout: some View {
        ZStack {
            ForEach(Array(pipPositions.enumerated()), id: \.offset) { _, pt in
                Circle()
                    .fill(pipColor)
                    .frame(width: pipSize, height: pipSize)
                    .position(x: pt.x, y: pt.y)
            }
        }
        .frame(width: faceSize, height: faceSize)
    }
}

#Preview {
    NavigationStack { DiceRollerView() }
}
