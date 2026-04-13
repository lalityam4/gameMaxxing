import SwiftUI

struct TeamGeneratorView: View {
    enum Phase { case setup, active }

    @State private var names: [String] = []
    @State private var newName: String = ""
    @State private var teamCount: Int = 2
    @State private var teams: [[String]] = []
    @State private var phase: Phase = .setup
    @FocusState private var focused: Bool

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            if phase == .setup {
                setupView
            } else {
                activeView
            }
        }
        .navigationTitle("Team Generator")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
    }

    // MARK: - Setup View

    private var setupView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                pageHeader
                addSection
                if !names.isEmpty {
                    nameListSection
                }
                teamCountSection
                generateButton
            }
            .padding(.bottom, 60)
        }
    }

    // MARK: - Active View

    private var activeView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                activeHeader
                teamsSection
                bottomButtons
            }
            .padding(.bottom, 60)
        }
    }

    // MARK: - Page Header (Setup)

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("👥")
                .font(.system(size: 44))
            Text("Team Generator")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("Add players and split them into teams.")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    // MARK: - Add Section

    private var addSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            RetroSectionHeader(title: "Players")

            HStack(spacing: 10) {
                TextField("Enter a name", text: $newName)
                    .font(.retroSerif(16))
                    .foregroundStyle(Color.retroInk)
                    .tint(Color.retroRust)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 11)
                    .background(Color.retroCard)
                    .overlay(Rectangle().stroke(
                        focused ? Color.retroRust : Color.retroBorder,
                        lineWidth: 1
                    ))
                    .focused($focused)
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

    // MARK: - Name List

    private var nameListSection: some View {
        VStack(spacing: 0) {
            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)
                .padding(.top, 8)

            ForEach(Array(names.enumerated()), id: \.offset) { idx, name in
                HStack(spacing: 14) {
                    Text(String(format: "%02d", idx + 1))
                        .font(.retroSerif(15))
                        .foregroundStyle(Color.retroBrown)
                        .frame(width: 28, alignment: .leading)

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

    // MARK: - Team Count Picker

    private var teamCountSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            RetroSectionHeader(title: "Number of Teams")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(2...8, id: \.self) { count in
                        Button {
                            teamCount = count
                        } label: {
                            Text("\(count)")
                                .font(.retroMono(15))
                                .foregroundStyle(teamCount == count ? Color.retroCream : Color.retroBrown)
                                .frame(width: 48, height: 48)
                                .background(teamCount == count ? Color.retroInk : Color.retroCard)
                                .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 8)
    }

    // MARK: - Generate Button

    private var generateButton: some View {
        Button {
            generateTeams()
        } label: {
            Text("Generate Teams →")
                .font(.retroSerif(17, weight: .bold))
                .foregroundStyle(Color.retroCream)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(names.count < 2 ? Color.retroBrown.opacity(0.4) : Color.retroInk)
                .cornerRadius(4)
        }
        .disabled(names.count < 2)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }

    // MARK: - Active Header

    private var activeHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("👥")
                .font(.system(size: 44))
            Text("Teams")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("\(teams.count) TEAMS · \(names.count) PLAYERS")
                .font(.retroMono(11))
                .tracking(1.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    // MARK: - Teams Section

    private var teamsSection: some View {
        VStack(spacing: 12) {
            ForEach(Array(teams.enumerated()), id: \.offset) { idx, team in
                VStack(alignment: .leading, spacing: 0) {
                    Text(String(format: "TEAM %02d", idx + 1))
                        .font(.retroMono(11))
                        .tracking(2)
                        .foregroundStyle(Color.retroRust)
                        .padding(.horizontal, 16)
                        .padding(.top, 14)
                        .padding(.bottom, 10)

                    Rectangle().fill(Color.retroBorder).frame(height: 1)
                        .padding(.horizontal, 16)

                    ForEach(Array(team.enumerated()), id: \.offset) { pIdx, player in
                        HStack(spacing: 12) {
                            Text(String(format: "%02d", pIdx + 1))
                                .font(.retroMono(11))
                                .foregroundStyle(Color.retroBrown)
                                .frame(width: 22, alignment: .leading)
                            Text(player)
                                .font(.retroSerif(15))
                                .foregroundStyle(Color.retroInk)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 11)
                        .overlay(alignment: .bottom) {
                            if pIdx < team.count - 1 {
                                Rectangle().fill(Color.retroBorder).frame(height: 1)
                                    .padding(.horizontal, 16)
                            }
                        }
                    }

                    Color.clear.frame(height: 4)
                }
                .background(Color.retroCard)
                .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 4)
    }

    // MARK: - Bottom Buttons

    private var bottomButtons: some View {
        VStack(spacing: 12) {
            Button {
                generateTeams()
            } label: {
                Text("Re-shuffle →")
                    .font(.retroSerif(17, weight: .bold))
                    .foregroundStyle(Color.retroCream)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.retroInk)
                    .cornerRadius(4)
            }
            .padding(.horizontal, 20)

            Button {
                phase = .setup
                teams = []
            } label: {
                Text("Start Over")
                    .font(.retroMono(13))
                    .tracking(0.5)
                    .foregroundStyle(Color.retroBrown)
            }
            .padding(.top, 4)
        }
        .padding(.top, 24)
    }

    // MARK: - Actions

    private func addName() {
        let name = newName.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty, !names.contains(name) else { return }
        names.append(name)
        newName = ""
    }

    private func generateTeams() {
        var buckets: [[String]] = Array(repeating: [], count: teamCount)
        let shuffled = names.shuffled()
        for (idx, name) in shuffled.enumerated() {
            buckets[idx % teamCount].append(name)
        }
        teams = buckets
        phase = .active
    }
}

#Preview {
    NavigationStack { TeamGeneratorView() }
}
