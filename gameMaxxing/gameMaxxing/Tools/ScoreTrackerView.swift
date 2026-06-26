import SwiftUI

struct ScoreTrackerView: View {
    @State private var players: [TrackedPlayer] = []
    @State private var round: Int = 1
    @State private var newName: String = ""
    @State private var showingAddPlayer = false
    @State private var history: [RoundSnapshot] = []
    @FocusState private var nameFieldFocused: Bool
    @FocusState private var focusedScoreID: UUID?

    var leader: TrackedPlayer? {
        players.max(by: { $0.total < $1.total })
    }

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if players.isEmpty {
                        emptyState
                    } else {
                        roundHeader
                        scoreTable
                        controls
                        if !history.isEmpty {
                            historySection
                        }
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Score Tracker")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !players.isEmpty {
                    Button {
                        focusedScoreID = nil
                        showingAddPlayer = true
                    } label: {
                        Image(systemName: "person.badge.plus")
                            .foregroundStyle(Color.retroBrown)
                    }
                }
            }
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focusedScoreID = nil }
                    .font(.retroMono(13))
                    .foregroundStyle(Color.retroRust)
            }
        }
        .sheet(isPresented: $showingAddPlayer) {
            addPlayerSheet
        }
        .onAppear {
            if players.isEmpty { showingAddPlayer = true }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("📊")
                    .font(.system(size: 44))
                Text("Score Tracker")
                    .font(.retroSerif(30, weight: .bold))
                    .foregroundStyle(Color.retroInk)
                Rectangle()
                    .fill(Color.retroRust)
                    .frame(width: 40, height: 2)
                Text("Add players to start tracking scores.")
                    .font(.retroMono(11))
                    .tracking(0.5)
                    .foregroundStyle(Color.retroBrown)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 28)

            Button {
                showingAddPlayer = true
            } label: {
                Text("Add Players →")
                    .font(.retroSerif(17, weight: .bold))
                    .foregroundStyle(Color.retroCream)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.retroInk)
                    .cornerRadius(4)
            }
            .padding(.horizontal, 20)
        }
    }

    // MARK: - Round Header

    private var roundHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("ROUND \(round)")
                    .font(.retroMono(10))
                    .tracking(2)
                    .foregroundStyle(Color.retroRust)
                Text("Score Tracker")
                    .font(.retroSerif(26, weight: .bold))
                    .foregroundStyle(Color.retroInk)
            }
            Spacer()
            if let lead = leader, lead.total > 0 {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("LEADING")
                        .font(.retroMono(9))
                        .tracking(1.5)
                        .foregroundStyle(Color.retroBrown)
                    Text(lead.name)
                        .font(.retroSerif(15, weight: .semibold))
                        .foregroundStyle(Color.retroRust)
                    Text("\(lead.total) pts")
                        .font(.retroMono(11))
                        .foregroundStyle(Color.retroBrown)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 16)
    }

    // MARK: - Score Table

    private var scoreTable: some View {
        VStack(spacing: 0) {
            // Column headers
            HStack(spacing: 0) {
                Text("#")
                    .font(.retroMono(9))
                    .tracking(1)
                    .foregroundStyle(Color.retroBrown)
                    .frame(width: 30, alignment: .leading)
                Text("PLAYER")
                    .font(.retroMono(9))
                    .tracking(1)
                    .foregroundStyle(Color.retroBrown)
                Spacer()
                Text("THIS ROUND")
                    .font(.retroMono(9))
                    .tracking(1)
                    .foregroundStyle(Color.retroBrown)
                    .frame(width: 108, alignment: .center)
                Text("TOTAL")
                    .font(.retroMono(9))
                    .tracking(1)
                    .foregroundStyle(Color.retroBrown)
                    .frame(width: 52, alignment: .trailing)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(Color.retroCard)
            .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))

            ForEach(Array(players.enumerated()), id: \.element.id) { idx, _ in
                playerRow(index: idx)
            }
        }
    }

    @ViewBuilder
    private func playerRow(index: Int) -> some View {
        let isLeader = players[index].id == leader?.id && players[index].total > 0
        let isFocused = focusedScoreID == players[index].id

        HStack(spacing: 0) {
            Text(String(format: "%02d", index + 1))
                .font(.retroSerif(16))
                .foregroundStyle(isLeader ? Color.retroRust : Color.retroBrown)
                .frame(width: 30, alignment: .leading)

            Text(players[index].name)
                .font(.retroSerif(15, weight: isLeader ? .semibold : .regular))
                .foregroundStyle(isLeader ? Color.retroRust : Color.retroInk)
                .lineLimit(1)

            Spacer()

            // Stepper with editable center field
            HStack(spacing: 0) {
                Button {
                    players[index].roundScore -= 1
                } label: {
                    Text("−")
                        .font(.retroSerif(18, weight: .semibold))
                        .foregroundStyle(Color.retroBrown)
                        .frame(width: 32, height: 36)
                        .background(Color.retroCard)
                        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                }

                TextField("0", text: Binding(
                    get: { players[index].roundScoreText },
                    set: { players[index].roundScoreText = $0 }
                ))
                .font(.retroMono(15))
                .foregroundStyle(Color.retroInk)
                .multilineTextAlignment(.center)
                .keyboardType(.numbersAndPunctuation)
                .frame(width: 44, height: 36)
                .background(isFocused ? Color.retroCard : Color.clear)
                .overlay(
                    Rectangle()
                        .stroke(isFocused ? Color.retroRust : Color.retroBorder, lineWidth: isFocused ? 2 : 1)
                        .padding(.horizontal, -1)
                )
                .focused($focusedScoreID, equals: players[index].id)
                .onTapGesture {
                    focusedScoreID = players[index].id
                    // Select all text on tap
                    DispatchQueue.main.async {
                        UIApplication.shared.sendAction(#selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil)
                    }
                }

                Button {
                    players[index].roundScore += 1
                } label: {
                    Text("+")
                        .font(.retroSerif(18, weight: .semibold))
                        .foregroundStyle(Color.retroRust)
                        .frame(width: 32, height: 36)
                        .background(Color.retroCard)
                        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                }
            }
            .frame(width: 108)

            Text("\(players[index].total)")
                .font(.retroSerif(16, weight: .semibold))
                .foregroundStyle(isLeader ? Color.retroRust : Color.retroInk)
                .frame(width: 52, alignment: .trailing)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.retroBorder).frame(height: 1)
                .padding(.horizontal, 20)
        }
    }

    // MARK: - Controls

    private var controls: some View {
        VStack(spacing: 12) {
            Button {
                focusedScoreID = nil
                endRound()
            } label: {
                Text("End Round \(round) →")
                    .font(.retroSerif(17, weight: .bold))
                    .foregroundStyle(Color.retroCream)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.retroInk)
                    .cornerRadius(4)
            }

            Button(role: .destructive) {
                reset()
            } label: {
                Text("Reset All Scores")
                    .font(.retroMono(12))
                    .tracking(0.5)
                    .foregroundStyle(Color.retroBrown)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 8)
    }

    // MARK: - History Section

    private let historyRndCol: CGFloat = 40
    private let historyPlayerCol: CGFloat = 64

    private var historySection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Round History")

            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header row
                    HStack(spacing: 0) {
                        Text("RND")
                            .font(.retroMono(9))
                            .tracking(1)
                            .foregroundStyle(Color.retroBrown)
                            .frame(width: historyRndCol, alignment: .leading)
                        ForEach(players) { player in
                            Text(player.name)
                                .font(.retroMono(9))
                                .tracking(0.5)
                                .foregroundStyle(Color.retroBrown)
                                .lineLimit(1)
                                .frame(width: historyPlayerCol, alignment: .center)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color.retroCard)
                    .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))

                    ForEach(history) { snapshot in
                        historyRow(snapshot: snapshot)
                    }

                    // Totals row
                    HStack(spacing: 0) {
                        Text("TOT")
                            .font(.retroMono(9))
                            .tracking(1)
                            .foregroundStyle(Color.retroBrown)
                            .frame(width: historyRndCol, alignment: .leading)
                        ForEach(players) { player in
                            let isLead = player.id == leader?.id && player.total > 0
                            Text("\(player.total)")
                                .font(.retroSerif(14, weight: .semibold))
                                .foregroundStyle(isLead ? Color.retroRust : Color.retroInk)
                                .frame(width: historyPlayerCol, alignment: .center)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.retroCard)
                    .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                }
                .frame(minWidth: UIScreen.main.bounds.width)
            }
        }
        .padding(.top, 24)
    }

    @ViewBuilder
    private func historyRow(snapshot: RoundSnapshot) -> some View {
        HStack(spacing: 0) {
            Text("\(snapshot.round)")
                .font(.retroMono(12))
                .foregroundStyle(Color.retroBrown)
                .frame(width: historyRndCol, alignment: .leading)
            ForEach(players) { player in
                let score = snapshot.scores.first(where: { $0.playerID == player.id })?.score ?? 0
                let isTop = score == (snapshot.scores.max(by: { $0.score < $1.score })?.score ?? 0) && score > 0
                Text("\(score)")
                    .font(.retroSerif(14, weight: isTop ? .semibold : .regular))
                    .foregroundStyle(isTop ? Color.retroRust : Color.retroInk)
                    .frame(width: historyPlayerCol, alignment: .center)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.retroBorder).frame(height: 1)
                .padding(.horizontal, 20)
        }
    }

    // MARK: - Add Player Sheet

    private var addPlayerSheet: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 24) {
                Text("Add Players")
                    .font(.retroSerif(24, weight: .bold))
                    .foregroundStyle(Color.retroInk)
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("PLAYER NAME")
                        .font(.retroMono(10))
                        .tracking(2)
                        .foregroundStyle(Color.retroBrown)
                    HStack(spacing: 10) {
                        TextField("Enter name", text: $newName)
                            .font(.retroSerif(17))
                            .foregroundStyle(Color.retroInk)
                            .tint(Color.retroRust)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 12)
                            .background(Color.retroCard)
                            .overlay(Rectangle().stroke(
                                nameFieldFocused ? Color.retroRust : Color.retroBorder,
                                lineWidth: 1
                            ))
                            .focused($nameFieldFocused)
                            .onSubmit { addPlayer() }

                        Button(action: addPlayer) {
                            Text("Add")
                                .font(.retroSerif(15, weight: .semibold))
                                .foregroundStyle(Color.retroCream)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(newName.trimmingCharacters(in: .whitespaces).isEmpty
                                            ? Color.retroBrown.opacity(0.4)
                                            : Color.retroInk)
                                .cornerRadius(4)
                        }
                        .disabled(newName.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                }

                if !players.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("ADDED (\(players.count))")
                            .font(.retroMono(10))
                            .tracking(2)
                            .foregroundStyle(Color.retroBrown)
                        ForEach(Array(players.enumerated()), id: \.element.id) { idx, p in
                            HStack {
                                Text(String(format: "%02d", idx + 1))
                                    .font(.retroSerif(15))
                                    .foregroundStyle(Color.retroRust)
                                    .frame(width: 28, alignment: .leading)
                                Text(p.name)
                                    .font(.retroSerif(15))
                                    .foregroundStyle(Color.retroInk)
                                Spacer()
                                Button {
                                    players.removeAll { $0.id == p.id }
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundStyle(Color.retroBrown)
                                }
                            }
                            .padding(.vertical, 6)
                            .overlay(alignment: .bottom) {
                                Rectangle().fill(Color.retroBorder).frame(height: 1)
                            }
                        }
                    }
                }

                Spacer()

                if !players.isEmpty {
                    Button {
                        showingAddPlayer = false
                    } label: {
                        Text("Start Tracking →")
                            .font(.retroSerif(17, weight: .bold))
                            .foregroundStyle(Color.retroCream)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.retroInk)
                            .cornerRadius(4)
                    }
                }
            }
            .padding(24)
        }
        .onAppear { nameFieldFocused = true }
    }

    // MARK: - Actions

    private func addPlayer() {
        let name = newName.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty else { return }
        players.append(TrackedPlayer(name: name))
        newName = ""
        nameFieldFocused = true
    }

    private func endRound() {
        let snapshot = RoundSnapshot(
            round: round,
            scores: players.map { ScoreEntry(playerID: $0.id, score: $0.roundScore) }
        )
        history.append(snapshot)

        for i in players.indices {
            players[i].total += players[i].roundScore
            players[i].roundScore = 0
        }
        round += 1

        withAnimation(.easeInOut(duration: 0.4)) {
            players.sort { $0.total > $1.total }
        }
    }

    private func reset() {
        players = []
        history = []
        round = 1
        showingAddPlayer = true
    }
}

// MARK: - Models

struct TrackedPlayer: Identifiable {
    let id = UUID()
    var name: String
    var total: Int = 0
    var roundScoreText: String = "0"

    var roundScore: Int {
        get { Int(roundScoreText) ?? 0 }
        set { roundScoreText = "\(newValue)" }
    }
}

struct ScoreEntry {
    let playerID: UUID
    let score: Int
}

struct RoundSnapshot: Identifiable {
    let id = UUID()
    let round: Int
    let scores: [ScoreEntry]
}

#Preview {
    NavigationStack { ScoreTrackerView() }
}
