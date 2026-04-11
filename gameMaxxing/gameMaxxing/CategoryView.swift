import SwiftUI

private enum DrinkFilter: String, CaseIterable {
    case all = "All"
    case drinking = "🍺 Drinking"
    case nonDrinking = "Non-Drinking"
}

private enum GameTab: String, CaseIterable {
    case library = "Library"
    case myGames = "My Games"
}

struct CategoryView: View {
    @Environment(GameStore.self) private var store
    let category: GameCategory

    @State private var showingAddGame = false
    @State private var showingDeleteCategory = false
    @State private var showingRenameCategory = false
    @State private var pendingCategoryName = ""
    @State private var gameTab: GameTab = .library
    @State private var drinkFilter: DrinkFilter = .all

    // MARK: - Computed Data

    private var allGames: [Game] {
        store.visibleGames(for: category)
    }

    private var tabFilteredGames: [Game] {
        switch gameTab {
        case .library: return allGames.filter { $0.isLibraryGame }
        case .myGames:  return allGames.filter { !$0.isLibraryGame }
        }
    }

    private var hasMixedDrinkContent: Bool {
        tabFilteredGames.contains { $0.isDrinkingGame } &&
        tabFilteredGames.contains { !$0.isDrinkingGame }
    }

    private var games: [Game] {
        guard hasMixedDrinkContent else { return tabFilteredGames }
        switch drinkFilter {
        case .all:         return tabFilteredGames
        case .drinking:    return tabFilteredGames.filter { $0.isDrinkingGame }
        case .nonDrinking: return tabFilteredGames.filter { !$0.isDrinkingGame }
        }
    }

    private func badge(for game: Game) -> String? {
        if game.isDrinkingGame { return "🍺" }
        if category.id == GameLibrary.cardGamesId { return "🥤" }
        return nil
    }

    private func deleteGame(_ game: Game) {
        if game.isLibraryGame {
            store.hideLibraryGame(game)
        } else {
            store.deleteCustomGame(game)
        }
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            List {
                // Header
                categoryHeader
                    .listRowBackground(Color.retroCream)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)

                // Library / My Games tab switcher
                tabBar
                    .listRowBackground(Color.retroCream)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)

                // Drink filter (only when tab has both types)
                if hasMixedDrinkContent {
                    filterBar
                        .listRowBackground(Color.retroCream)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                }

                // Top border
                Rectangle().fill(Color.retroInk).frame(height: 2)
                    .padding(.horizontal, 20)
                    .listRowBackground(Color.retroCream)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)

                // Games
                if games.isEmpty {
                    emptyState
                        .listRowBackground(Color.retroCream)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                } else {
                    ForEach(Array(games.enumerated()), id: \.element.id) { idx, game in
                        NavigationLink(destination: GameDetailView(game: game)) {
                            GameListRow(index: idx + 1, game: game, badge: badge(for: game))
                        }
                        .buttonStyle(.plain)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                deleteGame(game)
                            } label: {
                                Label(
                                    game.isLibraryGame ? "Remove" : "Delete",
                                    systemImage: "trash"
                                )
                            }
                        }
                        .listRowBackground(Color.retroCream)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                }

                // Add game row
                Button {
                    showingAddGame = true
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.retroRust)
                        Text("Add a game")
                            .font(.retroSerif(15))
                            .foregroundStyle(Color.retroRust)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .overlay(alignment: .bottom) {
                        Rectangle().fill(Color.retroBorder).frame(height: 1)
                            .padding(.horizontal, 20)
                    }
                }
                .listRowBackground(Color.retroCream)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)

                // Bottom padding
                Color.clear.frame(height: 40)
                    .listRowBackground(Color.retroCream)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        showingAddGame = true
                    } label: {
                        Label("Add Game", systemImage: "plus")
                    }

                    Button {
                        pendingCategoryName = category.name
                        showingRenameCategory = true
                    } label: {
                        Label("Rename Category", systemImage: "pencil")
                    }

                    if category.isCustom {
                        Button("Delete Category", role: .destructive) {
                            showingDeleteCategory = true
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundStyle(Color.retroBrown)
                }
            }
        }
        .sheet(isPresented: $showingAddGame) {
            AddEditGameView(categoryId: category.id)
        }
        .confirmationDialog(
            "Delete \"\(category.name)\"?",
            isPresented: $showingDeleteCategory,
            titleVisibility: .visible
        ) {
            Button("Delete Category & Its Games", role: .destructive) {
                store.deleteCustomCategory(category)
            }
        }
        .alert("Rename Category", isPresented: $showingRenameCategory) {
            TextField("Category name", text: $pendingCategoryName)
            Button("Save") {
                store.renameCategory(category, newName: pendingCategoryName)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Enter a new name for \"\(category.name)\"")
        }
    }

    // MARK: - Tab Bar

    private var tabBar: some View {
        HStack(spacing: 0) {
            ForEach(GameTab.allCases, id: \.self) { tab in
                Button {
                    gameTab = tab
                    drinkFilter = .all
                } label: {
                    Text(tab.rawValue)
                        .font(.retroMono(12))
                        .tracking(0.5)
                        .foregroundStyle(gameTab == tab ? Color.retroCream : Color.retroBrown)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(gameTab == tab ? Color.retroInk : Color.clear)
                }
                .buttonStyle(.plain)
            }
        }
        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }

    // MARK: - Filter Bar

    private var filterBar: some View {
        HStack(spacing: 0) {
            ForEach(DrinkFilter.allCases, id: \.self) { filter in
                Button {
                    drinkFilter = filter
                } label: {
                    Text(filter.rawValue)
                        .font(.retroMono(11))
                        .tracking(0.5)
                        .foregroundStyle(drinkFilter == filter ? Color.retroCream : Color.retroBrown)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(drinkFilter == filter ? Color.retroInk : Color.clear)
                }
                .buttonStyle(.plain)
            }
        }
        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }

    // MARK: - Header

    private var categoryHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(category.emoji)
                .font(.system(size: 44))
            Text(category.name)
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Text("\(allGames.count) game\(allGames.count == 1 ? "" : "s") · tap any to see how to play")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 20)
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 8) {
            Text(gameTab == .library ? "No library games." : "No custom games yet.")
                .font(.retroSerif(18))
                .foregroundStyle(Color.retroInk)
            Text(gameTab == .library
                 ? "Restore hidden games from the ··· menu above."
                 : "Tap 'Add a game' below to create one.")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(40)
    }
}

// MARK: - Game List Row

private struct GameListRow: View {
    let index: Int
    let game: Game
    var badge: String? = nil

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Text(String(format: "%02d", index))
                .font(.retroSerif(18))
                .foregroundStyle(Color.retroRust)
                .frame(width: 30, alignment: .leading)

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Text(game.name)
                        .font(.retroSerif(17, weight: .semibold))
                        .foregroundStyle(Color.retroInk)
                    if let badge {
                        Text(badge)
                            .font(.system(size: 13))
                    }
                }
                Text(game.description)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.retroBrown)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 8) {
                    Label(game.playersDisplay, systemImage: "person.2")
                        .font(.retroMono(10))
                        .foregroundStyle(Color.retroBrown)
                    Text("·")
                        .foregroundStyle(Color.retroBorder)
                    Text(game.duration)
                        .font(.retroMono(10))
                        .foregroundStyle(Color.retroBrown)
                    Text("·")
                        .foregroundStyle(Color.retroBorder)
                    Text(game.difficulty)
                        .font(.retroMono(10))
                        .foregroundStyle(Color.retroBrown)
                }
                .padding(.top, 2)
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
        CategoryView(category: GameLibrary.categories[0])
            .environment(GameStore())
    }
}
