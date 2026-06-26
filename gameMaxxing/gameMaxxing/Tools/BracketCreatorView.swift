import SwiftUI

// MARK: - Data Models

struct BracketMatch: Identifiable {
    let id = UUID()
    var topName: String
    var bottomName: String
    var winner: String? = nil

    var isReady: Bool {
        topName != "TBD" && bottomName != "TBD" &&
        topName != "BYE" && bottomName != "BYE"
    }
}

struct BracketRound: Identifiable {
    let id = UUID()
    let number: Int
    let name: String
    var matches: [BracketMatch]
}

// MARK: - BracketCreatorView

struct BracketCreatorView: View {

    enum BracketPhase { case setup, active }

    @State private var phase: BracketPhase = .setup
    @State private var names: [String] = []
    @State private var newName: String = ""
    @State private var bracketSize: Int = 8
    @State private var rounds: [BracketRound] = []
    @State private var currentRoundIndex: Int = 0
    @FocusState private var nameFieldFocused: Bool

    let bracketSizes = [4, 8, 16, 32]

    // MARK: - Layout Constants
    @State private var bracketHeight: CGFloat = 600

    private var r1Count:  Int      { max(1, rounds.first?.matches.count ?? 2) }
    private var cardStep: CGFloat  { (bracketHeight - padV * 2) / CGFloat(r1Count) }
    private var cardH:    CGFloat  { max(52, min(88, cardStep * 0.87)) }
    private var cardGap:  CGFloat  { cardStep - cardH }

    private let colW:  CGFloat = 188
    private let connW: CGFloat = 48
    private let padH:  CGFloat = 20
    private let padV:  CGFloat = 24

    private var canvasW: CGFloat {
        padH * 2 + CGFloat(rounds.count) * colW + CGFloat(max(0, rounds.count - 1)) * connW
    }
    private var canvasH: CGFloat { bracketHeight }

    // Vertical position (top edge) of match card at [roundIndex][matchIndex]
    private func cardTop(ri: Int, mi: Int) -> CGFloat {
        let slots  = pow(2.0, Double(ri))
        let slotH  = CGFloat(slots) * cardStep
        return padV + CGFloat(mi) * slotH + (slotH - cardH) / 2
    }
    // Vertical center of a match card
    private func cardMid(ri: Int, mi: Int) -> CGFloat { cardTop(ri: ri, mi: mi) + cardH / 2 }
    // Left edge of a round column
    private func colX(ri: Int) -> CGFloat { padH + CGFloat(ri) * (colW + connW) }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            Group {
                if phase == .setup {
                    setupView
                } else {
                    activeView
                }
            }
        }
        .navigationTitle("Bracket")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if phase == .active {
                    Button {
                        resetToSetup()
                    } label: {
                        Text("Reset")
                            .font(.retroMono(12))
                            .foregroundStyle(Color.retroBrown)
                    }
                }
            }
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { nameFieldFocused = false }
                    .font(.retroMono(13))
                    .foregroundStyle(Color.retroRust)
            }
        }
    }

    // MARK: - Setup View

    private var setupView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                pageHeader
                bracketSizePicker
                playerInputSection
                startButton
            }
            .padding(.bottom, 60)
        }
    }

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("🏆")
                .font(.system(size: 44))
            Text("Bracket Creator")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("Single-elimination tournament.")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    private var bracketSizePicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("BRACKET SIZE")
                .font(.retroMono(10))
                .tracking(2)
                .foregroundStyle(Color.retroBrown)
                .padding(.horizontal, 20)

            HStack(spacing: 10) {
                ForEach(bracketSizes, id: \.self) { size in
                    let isSelected = size == bracketSize
                    Button {
                        bracketSize = size
                        if names.count > size {
                            names = Array(names.prefix(size))
                        }
                    } label: {
                        Text("\(size)")
                            .font(.retroMono(15))
                            .foregroundStyle(isSelected ? Color.retroCream : Color.retroBrown)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(isSelected ? Color.retroInk : Color.retroCard)
                            .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 24)
    }

    private var playerInputSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("PLAYERS (\(names.count)/\(bracketSize))")
                .font(.retroMono(10))
                .tracking(2)
                .foregroundStyle(Color.retroBrown)
                .padding(.horizontal, 20)

            HStack(spacing: 10) {
                TextField("Enter a name", text: $newName)
                    .font(.retroSerif(16))
                    .foregroundStyle(Color.retroInk)
                    .tint(Color.retroRust)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 11)
                    .background(Color.retroCard)
                    .overlay(Rectangle().stroke(
                        nameFieldFocused ? Color.retroRust : Color.retroBorder,
                        lineWidth: 1
                    ))
                    .focused($nameFieldFocused)
                    .onSubmit { addName() }

                Button(action: addName) {
                    Text("Add")
                        .font(.retroSerif(15, weight: .semibold))
                        .foregroundStyle(Color.retroCream)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 11)
                        .background(
                            newName.trimmingCharacters(in: .whitespaces).isEmpty || names.count >= bracketSize
                                ? Color.retroBrown.opacity(0.4)
                                : Color.retroInk
                        )
                        .cornerRadius(4)
                }
                .disabled(newName.trimmingCharacters(in: .whitespaces).isEmpty || names.count >= bracketSize)
            }
            .padding(.horizontal, 20)

            if names.count < 2 {
                Text("(remaining slots will be filled with BYE)")
                    .font(.retroMono(10))
                    .italic()
                    .foregroundStyle(Color.retroBrown)
                    .padding(.horizontal, 20)
                    .padding(.top, 2)
            }

            if !names.isEmpty {
                VStack(spacing: 0) {
                    Rectangle().fill(Color.retroInk).frame(height: 2)
                        .padding(.horizontal, 20)
                        .padding(.top, 8)

                    ForEach(Array(names.enumerated()), id: \.offset) { idx, name in
                        HStack(spacing: 14) {
                            Text(String(format: "%02d", idx + 1))
                                .font(.retroSerif(16))
                                .foregroundStyle(Color.retroBrown)
                                .frame(width: 30, alignment: .leading)

                            Text(name)
                                .font(.retroSerif(15))
                                .foregroundStyle(Color.retroInk)

                            Spacer()

                            Button {
                                names.remove(at: idx)
                            } label: {
                                Image(systemName: "minus.circle")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color.retroBorder)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .overlay(alignment: .bottom) {
                            Rectangle().fill(Color.retroBorder).frame(height: 1)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
        .padding(.bottom, 24)
    }

    private var startButton: some View {
        Button {
            startBracket()
        } label: {
            Text("Start Bracket →")
                .font(.retroSerif(17, weight: .bold))
                .foregroundStyle(Color.retroCream)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(names.isEmpty ? Color.retroBrown.opacity(0.4) : Color.retroInk)
                .cornerRadius(4)
        }
        .disabled(names.isEmpty)
        .padding(.horizontal, 20)
    }

    // MARK: - Active View

    private var activeView: some View {
        VStack(spacing: 0) {
            // Champion banner
            if let finalRound = rounds.last, let champion = finalRound.matches.first?.winner {
                HStack(spacing: 10) {
                    Text("🏆").font(.system(size: 18))
                    Text("CHAMPION")
                        .font(.retroMono(10)).tracking(2)
                        .foregroundStyle(Color.retroCard.opacity(0.8))
                    Text(champion)
                        .font(.retroSerif(18, weight: .bold))
                        .foregroundStyle(Color.retroCream)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.retroInk)
            }

            // Stage rail + bracket canvas
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    stageRail(proxy: proxy)

                    ScrollView(.horizontal, showsIndicators: false) {
                        ZStack(alignment: .topLeading) {
                            // Canvas ground — sets the scroll area size
                            Color.clear
                                .frame(width: canvasW, height: canvasH)

                            // Connector lines drawn under the cards
                            bracketConnectors
                                .frame(width: canvasW, height: canvasH)
                                .allowsHitTesting(false)

                            // Round column scroll anchors
                            ForEach(0..<rounds.count, id: \.self) { ri in
                                Color.clear.frame(width: 1, height: 1)
                                    .offset(x: colX(ri: ri), y: 0)
                                    .id("col_\(ri)")
                            }

                            // Match cards
                            ForEach(Array(rounds.enumerated()), id: \.element.id) { ri, round in
                                ForEach(Array(round.matches.enumerated()), id: \.element.id) { mi, match in
                                    matchCard(match: match, roundIndex: ri, matchIndex: mi)
                                        .frame(width: colW, height: cardH)
                                        .offset(x: colX(ri: ri), y: cardTop(ri: ri, mi: mi))
                                }
                            }
                        }
                        .frame(width: canvasW, height: canvasH)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { h in
                        if h > 0 { bracketHeight = h }
                    }
                    .onScrollGeometryChange(for: CGFloat.self) { geo in
                        geo.contentOffset.x
                    } action: { _, x in
                        let center = x + 200.0
                        let ri = rounds.indices.last(where: { colX(ri: $0) <= center }) ?? 0
                        if ri != currentRoundIndex { currentRoundIndex = ri }
                    }
                }
            }
        }
    }

    // MARK: - Stage Rail

    private func stageRail(proxy: ScrollViewProxy) -> some View {
        ScrollViewReader { railProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(Array(rounds.enumerated()), id: \.element.id) { ri, round in
                        let isActive   = currentRoundIndex == ri
                        let isComplete = round.matches.allSatisfy { $0.winner != nil }

                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentRoundIndex = ri
                                proxy.scrollTo("col_\(ri)", anchor: .leading)
                            }
                        } label: {
                            VStack(spacing: 0) {
                                HStack(spacing: 5) {
                                    if isComplete {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 9, weight: .bold))
                                            .foregroundStyle(isActive ? Color.retroRust : Color.retroBrown.opacity(0.5))
                                    }
                                    Text(round.name.uppercased())
                                        .font(.retroMono(11))
                                        .tracking(1.5)
                                        .foregroundStyle(isActive ? Color.retroInk : Color.retroBrown)
                                }
                                .padding(.horizontal, 18)
                                .padding(.top, 14)
                                .padding(.bottom, 10)

                                Rectangle()
                                    .fill(isActive ? Color.retroRust : Color.clear)
                                    .frame(height: 2)
                            }
                        }
                        .buttonStyle(.plain)
                        .id("rail_\(ri)")

                        if ri < rounds.count - 1 {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 9, weight: .semibold))
                                .foregroundStyle(Color.retroBorder)
                                .padding(.bottom, 2)
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .background(Color.retroCream)
            .overlay(alignment: .bottom) {
                Rectangle().fill(Color.retroBorder).frame(height: 1)
            }
            .onChange(of: currentRoundIndex) { _, newValue in
                withAnimation { railProxy.scrollTo("rail_\(newValue)", anchor: .center) }
            }
        }
    }

    // MARK: - Bracket Connectors (Canvas)

    private var bracketConnectors: some View {
        Canvas { ctx, _ in
            let rust     = Color.retroRust
            let border   = Color.retroBorder
            let rustFade = Color.retroRust.opacity(0.45)

            for ri in 0..<(rounds.count - 1) {
                let fromRound = rounds[ri]
                var mi = 0
                while mi + 1 < fromRound.matches.count {
                    let topMatch  = fromRound.matches[mi]
                    let botMatch  = fromRound.matches[mi + 1]
                    let nextMi    = mi / 2
                    let nextMatch = rounds[ri + 1].matches[nextMi]

                    let x0    = colX(ri: ri) + colW           // right edge of from-column
                    let x2    = colX(ri: ri + 1)              // left edge of to-column
                    let x1    = x0 + (x2 - x0) / 2           // midpoint junction

                    let topY  = cardMid(ri: ri, mi: mi)
                    let botY  = cardMid(ri: ri, mi: mi + 1)
                    let nextY = cardMid(ri: ri + 1, mi: nextMi)

                    let topDone  = topMatch.winner  != nil
                    let botDone  = botMatch.winner  != nil
                    let nextDone = nextMatch.winner != nil

                    // Top horizontal arm
                    var p = Path()
                    p.move(to: CGPoint(x: x0, y: topY))
                    p.addLine(to: CGPoint(x: x1, y: topY))
                    ctx.stroke(p, with: .color(topDone ? rust : border), lineWidth: 2)

                    // Bottom horizontal arm
                    p = Path()
                    p.move(to: CGPoint(x: x0, y: botY))
                    p.addLine(to: CGPoint(x: x1, y: botY))
                    ctx.stroke(p, with: .color(botDone ? rust : border), lineWidth: 2)

                    // Vertical spine joining top & bottom arms
                    p = Path()
                    p.move(to: CGPoint(x: x1, y: topY))
                    p.addLine(to: CGPoint(x: x1, y: botY))
                    ctx.stroke(p, with: .color((topDone || botDone) ? rust : border), lineWidth: 2)

                    // Outgoing arm → next round match
                    let outColor = nextDone ? rustFade : (topDone || botDone) ? rust : border
                    p = Path()
                    p.move(to: CGPoint(x: x1, y: nextY))
                    p.addLine(to: CGPoint(x: x2, y: nextY))
                    ctx.stroke(p, with: .color(outColor), lineWidth: 2)

                    mi += 2
                }
            }
        }
    }

    private func matchCard(match: BracketMatch, roundIndex: Int, matchIndex: Int) -> some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                playerRow(
                    name: match.topName,
                    isWinner: match.winner == match.topName,
                    someoneWon: match.winner != nil,
                    match: match,
                    roundIndex: roundIndex,
                    matchIndex: matchIndex,
                    isTop: true
                )

                Rectangle()
                    .fill(Color.retroBorder)
                    .frame(height: 1)

                playerRow(
                    name: match.bottomName,
                    isWinner: match.winner == match.bottomName,
                    someoneWon: match.winner != nil,
                    match: match,
                    roundIndex: roundIndex,
                    matchIndex: matchIndex,
                    isTop: false
                )
            }
            .background(Color.retroCard)
            .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))

            Text("M\(matchIndex + 1)")
                .font(.retroMono(9))
                .foregroundStyle(Color.retroBorder)
                .padding(.trailing, 6)
                .padding(.bottom, 4)
        }
    }

    @ViewBuilder
    private func playerRow(
        name: String,
        isWinner: Bool,
        someoneWon: Bool,
        match: BracketMatch,
        roundIndex: Int,
        matchIndex: Int,
        isTop: Bool
    ) -> some View {
        let isTBD = name == "TBD"
        let isBYE = name == "BYE"
        let isLoser = someoneWon && !isWinner
        let canTap = match.isReady

        HStack {
            if isTBD || isBYE {
                Text(isTBD ? "TBD" : "BYE")
                    .font(.retroSerif(15))
                    .italic()
                    .foregroundStyle(Color.retroBrown)
            } else {
                Text(name)
                    .font(.retroSerif(15, weight: isWinner ? .semibold : .regular))
                    .foregroundStyle(
                        isWinner ? Color.retroRust :
                        isLoser  ? Color.retroBrown :
                        Color.retroInk
                    )
            }

            Spacer()

            if isWinner {
                Text("✓")
                    .font(.retroSerif(15, weight: .bold))
                    .foregroundStyle(Color.retroRust)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .contentShape(Rectangle())
        .onTapGesture {
            guard canTap else { return }
            let tappedName = isTop ? match.topName : match.bottomName

            if match.winner != nil {
                // Re-pick: reset downstream then advance new winner
                resetDownstream(fromRound: roundIndex, matchIndex: matchIndex)
                advanceWinner(roundIndex: roundIndex, matchIndex: matchIndex, winner: tappedName)
            } else {
                advanceWinner(roundIndex: roundIndex, matchIndex: matchIndex, winner: tappedName)
            }
        }
        .disabled(!canTap)
    }

    // MARK: - Bracket Generation

    private func startBracket() {
        var seeds = names
        while seeds.count < bracketSize { seeds.append("BYE") }

        let numRounds = Int(log2(Double(bracketSize)))
        var allRounds: [BracketRound] = []

        // Round 1
        var r1Matches: [BracketMatch] = []
        for i in stride(from: 0, to: seeds.count, by: 2) {
            r1Matches.append(BracketMatch(topName: seeds[i], bottomName: seeds[i + 1]))
        }
        allRounds.append(BracketRound(number: 1, name: roundName(1, total: numRounds), matches: r1Matches))

        // Subsequent rounds with TBD
        if numRounds >= 2 {
            for r in 2...numRounds {
                let matchCount = bracketSize / Int(pow(2.0, Double(r)))
                let matches = (0..<matchCount).map { _ in BracketMatch(topName: "TBD", bottomName: "TBD") }
                allRounds.append(BracketRound(number: r, name: roundName(r, total: numRounds), matches: matches))
            }
        }

        rounds = allRounds
        currentRoundIndex = 0
        phase = .active

        // Auto-advance BYE matches in round 1
        for (mi, match) in rounds[0].matches.enumerated() {
            if match.topName == "BYE" {
                advanceWinner(roundIndex: 0, matchIndex: mi, winner: match.bottomName)
            } else if match.bottomName == "BYE" {
                advanceWinner(roundIndex: 0, matchIndex: mi, winner: match.topName)
            }
        }
    }

    private func roundName(_ r: Int, total: Int) -> String {
        if r == total     { return "Final" }
        if r == total - 1 { return "Semifinals" }
        if r == total - 2 { return "Quarterfinals" }
        return "Round \(r)"
    }

    // MARK: - Winner Advancement

    private func advanceWinner(roundIndex: Int, matchIndex: Int, winner: String) {
        rounds[roundIndex].matches[matchIndex].winner = winner

        guard roundIndex + 1 < rounds.count else { return }
        let nextMatchIndex = matchIndex / 2
        if matchIndex % 2 == 0 {
            rounds[roundIndex + 1].matches[nextMatchIndex].topName = winner
        } else {
            rounds[roundIndex + 1].matches[nextMatchIndex].bottomName = winner
        }

        // Auto-advance if next match has a BYE
        let nextMatch = rounds[roundIndex + 1].matches[nextMatchIndex]
        if nextMatch.topName == "BYE" {
            advanceWinner(roundIndex: roundIndex + 1, matchIndex: nextMatchIndex, winner: nextMatch.bottomName)
        } else if nextMatch.bottomName == "BYE" {
            advanceWinner(roundIndex: roundIndex + 1, matchIndex: nextMatchIndex, winner: nextMatch.topName)
        }
    }

    private func resetDownstream(fromRound roundIndex: Int, matchIndex: Int) {
        guard roundIndex + 1 < rounds.count else { return }
        let nextMatchIndex = matchIndex / 2
        rounds[roundIndex + 1].matches[nextMatchIndex].winner = nil
        if matchIndex % 2 == 0 {
            rounds[roundIndex + 1].matches[nextMatchIndex].topName = "TBD"
        } else {
            rounds[roundIndex + 1].matches[nextMatchIndex].bottomName = "TBD"
        }
        resetDownstream(fromRound: roundIndex + 1, matchIndex: nextMatchIndex)
    }

    // MARK: - Reset

    private func resetToSetup() {
        rounds = []
        currentRoundIndex = 0
        phase = .setup
    }

    // MARK: - Add Name

    private func addName() {
        let name = newName.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty, names.count < bracketSize else { return }
        names.append(name)
        newName = ""
        nameFieldFocused = true
    }
}

#Preview {
    NavigationStack { BracketCreatorView() }
}
