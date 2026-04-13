import SwiftUI

// MARK: - GameTool Enum

enum GameTool: String, CaseIterable, Hashable {
    case scoreTracker      = "Score Tracker"
    case namePicker        = "Name Picker"
    case timer             = "Timer"
    case coinFlip          = "Coin Flip"
    case diceRoller        = "Dice Roller"
    case drinkDistributor  = "Drink Distributor"
    case bracketCreator    = "Bracket Creator"
    case randomMatching    = "Randomized Matching"
    case roundRobin        = "Round Robin"
    case randomNumber      = "Random Number"
    case teamGenerator     = "Team Generator"

    var emoji: String {
        switch self {
        case .scoreTracker:     return "📊"
        case .namePicker:       return "🎯"
        case .timer:            return "⏱"
        case .coinFlip:         return "🪙"
        case .diceRoller:       return "🎲"
        case .drinkDistributor: return "🍺"
        case .bracketCreator:   return "🏆"
        case .randomMatching:   return "🔀"
        case .roundRobin:       return "🔄"
        case .randomNumber:     return "🔢"
        case .teamGenerator:    return "👥"
        }
    }

    var tagline: String {
        switch self {
        case .scoreTracker:     return "Track scores across multiple rounds."
        case .namePicker:       return "Pick a random player or shuffle turn order."
        case .timer:            return "Countdown timer for timed rounds."
        case .coinFlip:         return "Heads or tails — settle it fairly."
        case .diceRoller:       return "Roll one or more dice, any number of sides."
        case .drinkDistributor: return "Assign drinks to players with a running log."
        case .bracketCreator:   return "Single-elimination tournament brackets."
        case .randomMatching:   return "Secretly assign each player another player."
        case .roundRobin:       return "Schedule every player against every other."
        case .randomNumber:     return "Generate a random number in any range."
        case .teamGenerator:    return "Randomly split players into teams."
        }
    }
}

// MARK: - Tools Hub View

struct ToolsHubView: View {
    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("🛠")
                            .font(.system(size: 44))
                        Text("Tools")
                            .font(.retroSerif(30, weight: .bold))
                            .foregroundStyle(Color.retroInk)
                        Rectangle()
                            .fill(Color.retroRust)
                            .frame(width: 40, height: 2)
                        Text("Helpers for scoring, picking, timing, and more.")
                            .font(.retroMono(11))
                            .tracking(0.5)
                            .foregroundStyle(Color.retroBrown)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 20)

                    // Top border
                    Rectangle().fill(Color.retroInk).frame(height: 2)
                        .padding(.horizontal, 20)

                    // Tool rows
                    ForEach(Array(GameTool.allCases.enumerated()), id: \.element) { idx, tool in
                        NavigationLink(destination: toolDestination(for: tool)) {
                            ToolListRow(index: idx + 1, tool: tool)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
    }

    @ViewBuilder
    private func toolDestination(for tool: GameTool) -> some View {
        switch tool {
        case .scoreTracker:     ScoreTrackerView()
        case .namePicker:       NamePickerView()
        case .timer:            TimerToolView()
        case .coinFlip:         CoinFlipView()
        case .diceRoller:       DiceRollerView()
        case .drinkDistributor: DrinkDistributorView()
        case .bracketCreator:   BracketCreatorView()
        case .randomMatching:   RandomMatchingView()
        case .roundRobin:       RoundRobinView()
        case .randomNumber:     RandomNumberView()
        case .teamGenerator:    TeamGeneratorView()
        }
    }
}

// MARK: - Tool List Row

struct ToolListRow: View {
    let index: Int
    let tool: GameTool

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Text(String(format: "%02d", index))
                .font(.retroSerif(18))
                .foregroundStyle(Color.retroRust)
                .frame(width: 30, alignment: .leading)

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 8) {
                    Text(tool.emoji)
                        .font(.system(size: 16))
                    Text(tool.rawValue)
                        .font(.retroSerif(17, weight: .semibold))
                        .foregroundStyle(Color.retroInk)
                }
                Text(tool.tagline)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.retroBrown)
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color.retroBorder)
                .padding(.top, 4)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.retroBorder).frame(height: 1)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    NavigationStack {
        ToolsHubView()
    }
}
