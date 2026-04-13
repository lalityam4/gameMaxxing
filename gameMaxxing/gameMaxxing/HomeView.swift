import SwiftUI

struct HomeView: View {
    @Environment(GameStore.self) private var store
    @State private var searchText = ""
    @State private var showingAddCategory = false
    @State private var newCategoryName = ""
    @State private var newCategoryEmoji = "🎮"

    private var searchResults: [Game] {
        store.search(searchText)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.retroCream.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        headerBar
                        searchBar
                        if searchText.isEmpty {
                            categoriesSection
                            toolsEntryRow
                            recentSection
                        } else {
                            searchResultsSection
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddCategory) { addCategorySheet }
        }
    }

    // MARK: - Header
    private var headerBar: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                Text("GameMaxxing")
                    .font(.retroSerif(28, weight: .bold))
                    .foregroundStyle(Color.retroInk)
                if let name = store.currentUser?.displayName, !name.isEmpty {
                    Text("Welcome back, \(name.components(separatedBy: " ").first ?? name).")
                        .font(.retroMono(11))
                        .tracking(1)
                        .foregroundStyle(Color.retroBrown)
                }
            }
            Spacer()
            // Sign out menu
            Menu {
                Button("Sign Out", role: .destructive) { store.signOut() }
                Button("Restore Library Games") { store.restoreAllLibraryGames() }
            } label: {
                Image(systemName: "person.circle")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.retroBrown)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 16)
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14))
                .foregroundStyle(Color.retroBrown)
            TextField("Search games…", text: $searchText)
                .font(.system(size: 15))
                .foregroundStyle(Color.retroInk)
                .tint(Color.retroRust)
            if !searchText.isEmpty {
                Button { searchText = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.retroBorder)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
        .padding(.horizontal, 20)
        .padding(.bottom, 4)
    }

    // MARK: - Categories Section
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                RetroSectionHeader(title: "Browse by category")
                Spacer()
                Button {
                    showingAddCategory = true
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                            .font(.system(size: 10, weight: .bold))
                        Text("Add")
                            .font(.retroMono(10))
                            .tracking(1)
                    }
                    .foregroundStyle(Color.retroRust)
                }
                .padding(.trailing, 20)
                .padding(.top, 24)
            }

            let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(store.allCategories) { category in
                    NavigationLink(destination: CategoryView(category: category)) {
                        CategoryCell(category: category, count: store.visibleGames(for: category).count)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 4)
            .padding(.bottom, 8)
        }
    }

    // MARK: - Tools Entry Row

    private var toolsEntryRow: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Tools")

            NavigationLink(destination: ToolsHubView()) {
                HStack(spacing: 14) {
                    Text("🛠")
                        .font(.system(size: 24))
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Game Tools")
                            .font(.retroSerif(17, weight: .semibold))
                            .foregroundStyle(Color.retroInk)
                        Text("Score tracker, timer, name picker & more")
                            .font(.retroMono(10))
                            .tracking(0.5)
                            .foregroundStyle(Color.retroBrown)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.retroBorder)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Color.retroBorder).frame(height: 1)
                        .padding(.horizontal, 20)
                }
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: - Recent Section
    private var recentSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Recently added")

            // top border
            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)

            let recent = Array(store.allVisibleGames.suffix(5).reversed())
            ForEach(Array(recent.enumerated()), id: \.element.id) { idx, game in
                NavigationLink(destination: GameDetailView(game: game)) {
                    RecentGameRow(index: idx + 1, game: game, category: store.category(for: game))
                }
                .buttonStyle(.plain)
            }

            if store.allVisibleGames.isEmpty {
                Text("No games yet. Add one above.")
                    .font(.retroMono(12))
                    .foregroundStyle(Color.retroBrown)
                    .padding(20)
            }
        }
        .padding(.bottom, 40)
    }

    // MARK: - Search Results
    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "\(searchResults.count) result\(searchResults.count == 1 ? "" : "s")")

            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)

            if searchResults.isEmpty {
                Text("No games found.")
                    .font(.retroMono(12))
                    .foregroundStyle(Color.retroBrown)
                    .padding(20)
            } else {
                ForEach(Array(searchResults.enumerated()), id: \.element.id) { idx, game in
                    NavigationLink(destination: GameDetailView(game: game)) {
                        RecentGameRow(index: idx + 1, game: game, category: store.category(for: game))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.bottom, 40)
    }

    // MARK: - Add Category Sheet
    private var addCategorySheet: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 24) {
                Text("New Category")
                    .font(.retroSerif(24, weight: .bold))
                    .foregroundStyle(Color.retroInk)
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("EMOJI".uppercased())
                        .font(.retroMono(10))
                        .tracking(2)
                        .foregroundStyle(Color.retroBrown)
                    TextField("🎮", text: $newCategoryEmoji)
                        .font(.system(size: 36))
                        .frame(width: 60)
                        .padding(8)
                        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("NAME".uppercased())
                        .font(.retroMono(10))
                        .tracking(2)
                        .foregroundStyle(Color.retroBrown)
                    TextField("Category name", text: $newCategoryName)
                        .font(.retroSerif(17))
                        .foregroundStyle(Color.retroInk)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                }

                Spacer()

                Button {
                    guard !newCategoryName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    let emoji = newCategoryEmoji.isEmpty ? "🎮" : String(newCategoryEmoji.prefix(2))
                    store.addCustomCategory(GameCategory(name: newCategoryName.trimmingCharacters(in: .whitespaces), emoji: emoji, isCustom: true))
                    newCategoryName = ""
                    newCategoryEmoji = "🎮"
                    showingAddCategory = false
                } label: {
                    Text("Add Category")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.retroCream)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.retroInk)
                }
                .disabled(newCategoryName.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding(24)
        }
        .presentationDetents([.medium])
    }
}

// MARK: - Category Cell

private struct CategoryCell: View {
    let category: GameCategory
    let count: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(category.emoji)
                .font(.system(size: 28))
            Text(category.name)
                .font(.retroSerif(15, weight: .semibold))
                .foregroundStyle(Color.retroInk)
                .lineLimit(1)
            Text("\(count) game\(count == 1 ? "" : "s")")
                .font(.retroMono(10))
                .tracking(1)
                .foregroundStyle(Color.retroBrown)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.retroCard)
        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
    }
}

// MARK: - Recent Game Row

private struct RecentGameRow: View {
    let index: Int
    let game: Game
    let category: GameCategory?

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Text(String(format: "%02d", index))
                .font(.retroSerif(18))
                .foregroundStyle(Color.retroRust)
                .frame(width: 30, alignment: .leading)
            VStack(alignment: .leading, spacing: 4) {
                Text(game.name)
                    .font(.retroSerif(16, weight: .semibold))
                    .foregroundStyle(Color.retroInk)
                Text(game.description)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.retroBrown)
                    .lineLimit(2)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                if let cat = category {
                    Text(cat.emoji + " " + cat.name)
                        .font(.retroMono(10))
                        .tracking(0.5)
                        .foregroundStyle(Color.retroBrown)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Color.retroCard)
                }
                Text("👥 \(game.playersDisplay)")
                    .font(.retroMono(10))
                    .foregroundStyle(Color.retroBrown)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.retroBorder).frame(height: 1)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    HomeView()
        .environment(GameStore())
}
