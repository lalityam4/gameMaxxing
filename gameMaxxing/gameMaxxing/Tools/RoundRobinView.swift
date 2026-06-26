import SwiftUI

// MARK: - Models

struct RRMatch: Identifiable {
    let id = UUID()
    let teamA: String
    let teamB: String
    var result: RRResult = .pending
}

enum RRResult { case pending, aWins, bWins, draw }

struct RRRound: Identifiable {
    let id = UUID()
    let number: Int
    var matches: [RRMatch]
}

// MARK: - Standing Entry

struct RRStanding: Identifiable {
    let id: String  // player name
    var wins: Int = 0
    var draws: Int = 0
    var losses: Int = 0
    var points: Int { wins * 3 + draws }
    var played: Int { wins + draws + losses }
}

// MARK: - View

struct RoundRobinView: View {
    enum Phase { case setup, active }

    @State private var names: [String] = []
    @State private var newName: String = ""
    @State private var rounds: [RRRound] = []
    @State private var phase: Phase = .setup
    @FocusState private var nameFieldFocused: Bool

    private var totalMatches: Int {
        rounds.reduce(0) { $0 + $1.matches.count }
    }

    private var completedCount: Int {
        rounds.reduce(0) { $0 + $1.matches.filter { $0.result != .pending }.count }
    }

    private var standings: [RRStanding] {
        var table: [String: RRStanding] = [:]
        for name in names { table[name] = RRStanding(id: name) }
        for round in rounds {
            for match in round.matches where match.result != .pending {
                switch match.result {
                case .aWins:
                    table[match.teamA]?.wins   += 1
                    table[match.teamB]?.losses += 1
                case .bWins:
                    table[match.teamB]?.wins   += 1
                    table[match.teamA]?.losses += 1
                case .draw:
                    table[match.teamA]?.draws += 1
                    table[match.teamB]?.draws += 1
                case .pending: break
                }
            }
        }
        return table.values.sorted {
            if $0.points != $1.points { return $0.points > $1.points }
            if $0.wins   != $1.wins   { return $0.wins   > $1.wins   }
            return $0.id < $1.id
        }
    }

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if phase == .setup {
                        setupPhase
                    } else {
                        activePhase
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Round Robin")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
        .toolbar {
            if phase == .active {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            rounds = []
                            phase = .setup
                        }
                    } label: {
                        Text("Reset")
                            .font(.retroMono(12))
                            .foregroundStyle(Color.retroBrown)
                    }
                }
            }
        }
    }

    // MARK: - Setup Phase

    private var setupPhase: some View {
        VStack(alignment: .leading, spacing: 0) {
            pageHeader
            addSection
            if !names.isEmpty {
                nameListSection
            }
            generateButton
        }
    }

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("🔄")
                .font(.system(size: 44))
            Text("Round Robin")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("Every player faces every other player.")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    private var addSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            RetroSectionHeader(title: "Players / Teams")

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
                        .background(newName.trimmingCharacters(in: .whitespaces).isEmpty
                                    ? Color.retroBrown.opacity(0.4)
                                    : Color.retroInk)
                        .cornerRadius(4)
                }
                .disabled(newName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding(.horizontal, 20)
        }
    }

    private var nameListSection: some View {
        VStack(spacing: 0) {
            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)
                .padding(.top, 8)

            ForEach(Array(names.enumerated()), id: \.offset) { idx, name in
                HStack(spacing: 14) {
                    Text(String(format: "%02d", idx + 1))
                        .font(.retroSerif(18))
                        .foregroundStyle(Color.retroBrown)
                        .frame(width: 30, alignment: .leading)

                    Text(name)
                        .font(.retroSerif(16))
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
                .padding(.vertical, 13)
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Color.retroBorder).frame(height: 1)
                        .padding(.horizontal, 20)
                }
            }
        }
    }

    private var generateButton: some View {
        Button {
            rounds = generateSchedule(teams: names)
            phase = .active
        } label: {
            Text("Generate Schedule →")
                .font(.retroSerif(17, weight: .bold))
                .foregroundStyle(Color.retroCream)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(names.count < 2 ? Color.retroBrown.opacity(0.4) : Color.retroInk)
                .cornerRadius(4)
        }
        .disabled(names.count < 2)
        .padding(.horizontal, 20)
        .padding(.top, 24)
    }

    // MARK: - Active Phase

    private var activePhase: some View {
        VStack(alignment: .leading, spacing: 0) {
            activeHeader
            progressSection
            if completedCount > 0 { standingsSection }
            roundSections
        }
    }

    private var standingsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Standings")
            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)

            // Column headers
            HStack(spacing: 0) {
                Text("#")
                    .frame(width: 28, alignment: .leading)
                Text("PLAYER")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("P")
                    .frame(width: 28, alignment: .center)
                Text("W")
                    .frame(width: 28, alignment: .center)
                Text("D")
                    .frame(width: 28, alignment: .center)
                Text("L")
                    .frame(width: 28, alignment: .center)
                Text("PTS")
                    .frame(width: 40, alignment: .trailing)
            }
            .font(.retroMono(10))
            .tracking(1)
            .foregroundStyle(Color.retroBrown)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .overlay(alignment: .bottom) {
                Rectangle().fill(Color.retroBorder).frame(height: 1)
            }

            ForEach(Array(standings.enumerated()), id: \.element.id) { idx, row in
                let isLeader = idx == 0 && row.points > 0
                HStack(spacing: 0) {
                    Text("\(idx + 1)")
                        .font(.retroSerif(15))
                        .foregroundStyle(isLeader ? Color.retroRust : Color.retroBrown)
                        .frame(width: 28, alignment: .leading)
                    Text(row.id)
                        .font(.retroSerif(15, weight: isLeader ? .bold : .regular))
                        .foregroundStyle(Color.retroInk)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(row.played)")
                        .frame(width: 28, alignment: .center)
                    Text("\(row.wins)")
                        .frame(width: 28, alignment: .center)
                    Text("\(row.draws)")
                        .frame(width: 28, alignment: .center)
                    Text("\(row.losses)")
                        .frame(width: 28, alignment: .center)
                    Text("\(row.points)")
                        .font(.retroSerif(15, weight: .bold))
                        .foregroundStyle(isLeader ? Color.retroRust : Color.retroInk)
                        .frame(width: 40, alignment: .trailing)
                }
                .font(.retroMono(13))
                .foregroundStyle(Color.retroBrown)
                .padding(.horizontal, 20)
                .padding(.vertical, 11)
                .background(isLeader ? Color.retroRust.opacity(0.07) : Color.clear)
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Color.retroBorder).frame(height: 1)
                        .padding(.horizontal, 20)
                }
            }
        }
        .padding(.bottom, 8)
        .animation(.easeInOut(duration: 0.25), value: completedCount)
    }

    private var activeHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(rounds.count) ROUNDS · \(totalMatches) MATCHES TOTAL")
                .font(.retroMono(12))
                .tracking(1.5)
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 16)
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(completedCount) / \(totalMatches) PLAYED")
                .font(.retroMono(11))
                .tracking(1)
                .foregroundStyle(Color.retroBrown)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.retroCard)
                        .frame(height: 6)
                        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))

                    let progress = totalMatches > 0 ? CGFloat(completedCount) / CGFloat(totalMatches) : 0
                    Rectangle()
                        .fill(Color.retroRust)
                        .frame(width: geo.size.width * progress, height: 6)
                }
            }
            .frame(height: 6)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
        .animation(.easeInOut(duration: 0.3), value: completedCount)
    }

    private var roundSections: some View {
        ForEach(Array(rounds.enumerated()), id: \.element.id) { rIdx, round in
            VStack(alignment: .leading, spacing: 0) {
                // Round header
                HStack(spacing: 12) {
                    Text("ROUND \(round.number)")
                        .font(.retroMono(11))
                        .tracking(2)
                        .foregroundStyle(Color.retroRust)
                    Rectangle()
                        .fill(Color.retroBorder)
                        .frame(height: 1)
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 4)

                // Match rows
                ForEach(Array(round.matches.enumerated()), id: \.element.id) { mIdx, match in
                    matchRow(roundIndex: rIdx, matchIndex: mIdx, match: match)
                }
            }
        }
    }

    @ViewBuilder
    private func matchRow(roundIndex: Int, matchIndex: Int, match: RRMatch) -> some View {
        let isCompleted = match.result != .pending

        HStack(spacing: 0) {
            // Team A
            Text(match.teamA)
                .font(.retroSerif(14, weight: .semibold))
                .foregroundStyle(Color.retroInk)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)

            // vs
            Text("vs")
                .font(.retroMono(10))
                .foregroundStyle(Color.retroBrown)
                .padding(.horizontal, 8)

            // Team B
            Text(match.teamB)
                .font(.retroSerif(14, weight: .semibold))
                .foregroundStyle(Color.retroInk)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .trailing)

            // Result control
            HStack(spacing: 4) {
                resultBox(label: "A", isSelected: match.result == .aWins) {
                    setResult(roundIndex: roundIndex, matchIndex: matchIndex, result: .aWins)
                }
                resultBox(label: "=", isSelected: match.result == .draw) {
                    setResult(roundIndex: roundIndex, matchIndex: matchIndex, result: .draw)
                }
                resultBox(label: "B", isSelected: match.result == .bWins) {
                    setResult(roundIndex: roundIndex, matchIndex: matchIndex, result: .bWins)
                }
            }
            .padding(.leading, 12)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(isCompleted ? Color.retroCard.opacity(0.6) : Color.clear)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.retroBorder).frame(height: 1)
                .padding(.horizontal, 20)
        }
    }

    @ViewBuilder
    private func resultBox(label: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.retroMono(11))
                .foregroundStyle(isSelected ? Color.retroCream : Color.retroBrown)
                .frame(width: 32, height: 28)
                .background(isSelected ? Color.retroInk : Color.retroCard)
                .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    // MARK: - Logic

    private func addName() {
        let name = newName.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty, !names.contains(name) else { return }
        names.append(name)
        newName = ""
    }

    private func setResult(roundIndex: Int, matchIndex: Int, result: RRResult) {
        let current = rounds[roundIndex].matches[matchIndex].result
        // Tapping the already-selected result toggles back to pending
        rounds[roundIndex].matches[matchIndex].result = (current == result) ? .pending : result
    }

    private func generateSchedule(teams: [String]) -> [RRRound] {
        var pool = teams
        let hasBye = pool.count % 2 != 0
        if hasBye { pool.append("BYE") }
        let n = pool.count
        var generatedRounds: [RRRound] = []
        var rotating = Array(pool.dropFirst())
        for r in 0..<(n - 1) {
            let lineup = [pool[0]] + rotating
            var matches: [RRMatch] = []
            for i in 0..<(n / 2) {
                let a = lineup[i], b = lineup[n - 1 - i]
                if a != "BYE" && b != "BYE" {
                    matches.append(RRMatch(teamA: a, teamB: b))
                }
            }
            generatedRounds.append(RRRound(number: r + 1, matches: matches))
            rotating = [rotating.last!] + rotating.dropLast()
        }
        return generatedRounds
    }
}

#Preview {
    NavigationStack { RoundRobinView() }
}
