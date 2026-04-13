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
    @FocusState private var nameFieldFocused: Bool

    let bracketSizes = [4, 8, 16, 32]

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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                championBanner
                ForEach(Array(rounds.enumerated()), id: \.element.id) { ri, round in
                    roundSection(round: round, roundIndex: ri)
                }
            }
            .padding(.bottom, 60)
        }
    }

    @ViewBuilder
    private var championBanner: some View {
        if let finalRound = rounds.last, let champion = finalRound.matches.first?.winner {
            VStack(spacing: 6) {
                Text("🏆 CHAMPION")
                    .font(.retroMono(10))
                    .tracking(2)
                    .foregroundStyle(Color.retroCard)
                Text(champion)
                    .font(.retroSerif(28, weight: .bold))
                    .foregroundStyle(Color.retroCream)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .background(Color.retroInk)
        }
    }

    private func roundSection(round: BracketRound, roundIndex: Int) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                Text(round.name.uppercased())
                    .font(.retroMono(10))
                    .tracking(2)
                    .foregroundStyle(Color.retroRust)
                Rectangle()
                    .fill(Color.retroBorder)
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 8)

            VStack(spacing: 10) {
                ForEach(Array(round.matches.enumerated()), id: \.element.id) { mi, match in
                    matchCard(match: match, roundIndex: roundIndex, matchIndex: mi)
                }
            }
            .padding(.horizontal, 20)
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
