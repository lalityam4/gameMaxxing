import SwiftUI

struct CoinFlipView: View {
    enum CoinSide { case heads, tails }

    @State private var result:    CoinSide? = nil
    @State private var isFlipping: Bool     = false
    @State private var heads:     Int       = 0
    @State private var tails:     Int       = 0
    @State private var flipCount: Int       = 0

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    pageHeader
                    coinFace
                    flipButton
                    if heads + tails > 0 { tallySection }
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Coin Flip")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if heads + tails > 0 {
                    Button {
                        heads = 0; tails = 0; result = nil; flipCount = 0
                    } label: {
                        Text("Reset")
                            .font(.retroMono(12))
                            .foregroundStyle(Color.retroBrown)
                    }
                }
            }
        }
    }

    // MARK: - Page Header

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("🪙")
                .font(.system(size: 44))
            Text("Coin Flip")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("Heads or tails — settle it fairly.")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 28)
    }

    // MARK: - Coin Face

    private var coinFace: some View {
        VStack(spacing: 12) {
            ZStack {
                Rectangle()
                    .fill(Color.retroCard)
                    .frame(width: 180, height: 180)
                    .overlay(Rectangle().stroke(
                        result != nil ? Color.retroInk : Color.retroBorder,
                        lineWidth: result != nil ? 2 : 1
                    ))

                if isFlipping {
                    Text("?")
                        .font(.retroSerif(80, weight: .bold))
                        .foregroundStyle(Color.retroBorder)
                } else if let r = result {
                    VStack(spacing: 6) {
                        Text(r == .heads ? "H" : "T")
                            .font(.retroSerif(80, weight: .bold))
                            .foregroundStyle(r == .heads ? Color.retroInk : Color.retroRust)
                        Text(r == .heads ? "Heads" : "Tails")
                            .font(.retroMono(12))
                            .tracking(2)
                            .foregroundStyle(Color.retroBrown)
                    }
                } else {
                    Text("?")
                        .font(.retroSerif(80, weight: .bold))
                        .foregroundStyle(Color.retroBorder)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .animation(.easeInOut(duration: 0.15), value: isFlipping)

            if let r = result, !isFlipping {
                Text("FLIP #\(flipCount)")
                    .font(.retroMono(10))
                    .tracking(2)
                    .foregroundStyle(Color.retroBrown)
            }
        }
        .padding(.bottom, 24)
    }

    // MARK: - Flip Button

    private var flipButton: some View {
        Button {
            flip()
        } label: {
            Text(isFlipping ? "Flipping…" : (result == nil ? "Flip Coin →" : "Flip Again →"))
                .font(.retroSerif(17, weight: .bold))
                .foregroundStyle(Color.retroCream)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(isFlipping ? Color.retroBrown.opacity(0.5) : Color.retroInk)
                .cornerRadius(4)
        }
        .disabled(isFlipping)
        .padding(.horizontal, 20)
    }

    // MARK: - Tally

    private var tallySection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Tally — \(heads + tails) flips")

            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)

            HStack(spacing: 0) {
                tallyCell(label: "HEADS", count: heads, total: heads + tails)

                Rectangle().fill(Color.retroBorder).frame(width: 1, height: 80)

                tallyCell(label: "TAILS", count: tails, total: heads + tails)
            }
            .overlay(alignment: .bottom) {
                Rectangle().fill(Color.retroBorder).frame(height: 1)
                    .padding(.horizontal, 20)
            }
        }
        .padding(.top, 16)
    }

    @ViewBuilder
    private func tallyCell(label: String, count: Int, total: Int) -> some View {
        VStack(spacing: 6) {
            Text(label)
                .font(.retroMono(10))
                .tracking(2)
                .foregroundStyle(Color.retroBrown)
            Text("\(count)")
                .font(.retroSerif(40, weight: .bold))
                .foregroundStyle(Color.retroInk)
                .contentTransition(.numericText())
            if total > 0 {
                Text("\(Int(Double(count) / Double(total) * 100))%")
                    .font(.retroMono(11))
                    .foregroundStyle(Color.retroBrown)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
    }

    // MARK: - Flip Logic

    private func flip() {
        isFlipping = true
        result = nil
        var flashes = 0
        let total = Int.random(in: 10...16)
        Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { t in
            flashes += 1
            if flashes >= total {
                t.invalidate()
                let final: CoinSide = Bool.random() ? .heads : .tails
                result = final
                isFlipping = false
                flipCount += 1
                if final == .heads { heads += 1 } else { tails += 1 }
            }
        }
    }
}

#Preview {
    NavigationStack { CoinFlipView() }
}
