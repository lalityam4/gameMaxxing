import Foundation
import Observation

@Observable
final class GameStore {

    // MARK: - State
    var currentUser: UserProfile? = nil

    // MARK: - Computed: all categories (library + user custom, with any renames applied)
    var allCategories: [GameCategory] {
        let overrides = currentUser?.categoryNameOverrides ?? [:]
        let library = GameLibrary.categories.map { cat -> GameCategory in
            var c = cat
            if let renamed = overrides[cat.id] { c.name = renamed }
            return c
        }
        return library + (currentUser?.customCategories ?? [])
    }

    // MARK: - Computed: all visible games per category
    func visibleGames(for category: GameCategory) -> [Game] {
        let hidden = Set(currentUser?.hiddenLibraryGameIds ?? [])
        let library = GameLibrary.games
            .filter { $0.categoryId == category.id && !hidden.contains($0.id) }
        let custom = (currentUser?.customGames ?? [])
            .filter { $0.categoryId == category.id }
        return library + custom
    }

    var allVisibleGames: [Game] {
        allCategories.flatMap { visibleGames(for: $0) }
    }

    func category(for game: Game) -> GameCategory? {
        allCategories.first { $0.id == game.categoryId }
    }

    // MARK: - Auth: Local sign-in (no Apple account needed)
    func signInLocally(name: String) {
        // Reuse existing local ID if one was already created on this device
        let userId = UserDefaults.standard.string(forKey: "gm_currentUserId")
                     ?? UUID().uuidString
        let key = storageKey(userId)
        if let data = UserDefaults.standard.data(forKey: key),
           let profile = try? JSONDecoder().decode(UserProfile.self, from: data) {
            currentUser = profile
        } else {
            let profile = UserProfile(userId: userId, displayName: name)
            currentUser = profile
            save()
        }
        UserDefaults.standard.set(userId, forKey: "gm_currentUserId")
    }

    func signOut() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "gm_currentUserId")
    }

    // Restore the last signed-in session on cold launch.
    func restoreSession() {
        guard let userId = UserDefaults.standard.string(forKey: "gm_currentUserId") else { return }
        let key = storageKey(userId)
        if let data = UserDefaults.standard.data(forKey: key),
           let profile = try? JSONDecoder().decode(UserProfile.self, from: data) {
            currentUser = profile
        }
    }

    // MARK: - Persistence
    private func storageKey(_ userId: String) -> String { "gm_user_\(userId)" }

    func save() {
        guard let user = currentUser else { return }
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: storageKey(user.userId))
        }
    }

    // MARK: - Library Game Management
    func hideLibraryGame(_ game: Game) {
        guard game.isLibraryGame else { return }
        if currentUser?.hiddenLibraryGameIds.contains(game.id) == false {
            currentUser?.hiddenLibraryGameIds.append(game.id)
            save()
        }
    }

    func restoreAllLibraryGames() {
        currentUser?.hiddenLibraryGameIds = []
        save()
    }

    // MARK: - Custom Game CRUD
    func addCustomGame(_ game: Game) {
        currentUser?.customGames.append(game)
        save()
    }

    func updateCustomGame(_ updated: Game) {
        guard let idx = currentUser?.customGames.firstIndex(where: { $0.id == updated.id }) else { return }
        currentUser?.customGames[idx] = updated
        save()
    }

    func deleteCustomGame(_ game: Game) {
        currentUser?.customGames.removeAll { $0.id == game.id }
        save()
    }

    // MARK: - Custom Category CRUD
    func renameCategory(_ category: GameCategory, newName: String) {
        let trimmed = newName.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        if category.isCustom {
            if let idx = currentUser?.customCategories.firstIndex(where: { $0.id == category.id }) {
                currentUser?.customCategories[idx].name = trimmed
            }
        } else {
            currentUser?.categoryNameOverrides[category.id] = trimmed
        }
        save()
    }

    func addCustomCategory(_ category: GameCategory) {
        currentUser?.customCategories.append(category)
        save()
    }

    func deleteCustomCategory(_ category: GameCategory) {
        // Also remove custom games in this category
        currentUser?.customGames.removeAll { $0.categoryId == category.id }
        currentUser?.customCategories.removeAll { $0.id == category.id }
        save()
    }

    // MARK: - Search
    func search(_ query: String) -> [Game] {
        guard !query.isEmpty else { return [] }
        let q = query.lowercased()
        return allVisibleGames.filter {
            $0.name.lowercased().contains(q) ||
            $0.description.lowercased().contains(q)
        }
    }
}
