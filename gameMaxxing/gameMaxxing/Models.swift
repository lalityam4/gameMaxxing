import Foundation

// MARK: - Category

struct GameCategory: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var emoji: String
    var isCustom: Bool

    init(id: UUID = UUID(), name: String, emoji: String, isCustom: Bool = false) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.isCustom = isCustom
    }
}

// MARK: - Step

struct GameStep: Identifiable, Codable {
    var id: UUID
    var stepNumber: Int
    var title: String
    var description: String
    var sfSymbol: String          // auto-assigned as "\(n).circle.fill", user can override
    var customImageData: Data?    // photo added by user

    init(
        id: UUID = UUID(),
        stepNumber: Int,
        title: String,
        description: String,
        sfSymbol: String = "",
        customImageData: Data? = nil
    ) {
        self.id = id
        self.stepNumber = stepNumber
        self.title = title
        self.description = description
        self.sfSymbol = sfSymbol.isEmpty ? "\(min(stepNumber, 50)).circle.fill" : sfSymbol
        self.customImageData = customImageData
    }
}

// MARK: - Game

struct Game: Identifiable, Codable {
    var id: UUID
    var name: String
    var categoryId: UUID
    var description: String
    var steps: [GameStep]
    var whatYouNeed: [String]
    var minPlayers: Int
    var maxPlayers: Int           // use 99 to represent "no upper limit"
    var duration: String          // e.g. "15–30 min" or "Open-ended"
    var difficulty: String        // "Easy" | "Medium" | "Hard"
    var isDrinkingGame: Bool      // shows 🍺 badge; non-drinking card games show 🥤
    var isLibraryGame: Bool

    init(
        id: UUID = UUID(),
        name: String,
        categoryId: UUID,
        description: String,
        steps: [GameStep] = [],
        whatYouNeed: [String] = [],
        minPlayers: Int = 2,
        maxPlayers: Int = 8,
        duration: String = "",
        difficulty: String = "Easy",
        isDrinkingGame: Bool = false,
        isLibraryGame: Bool = false
    ) {
        self.id = id
        self.name = name
        self.categoryId = categoryId
        self.description = description
        self.steps = steps
        self.whatYouNeed = whatYouNeed
        self.minPlayers = minPlayers
        self.maxPlayers = maxPlayers
        self.duration = duration
        self.difficulty = difficulty
        self.isDrinkingGame = isDrinkingGame
        self.isLibraryGame = isLibraryGame
    }

    // Custom decoder so old saved games (without isDrinkingGame) still decode cleanly
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id            = try c.decode(UUID.self,       forKey: .id)
        name          = try c.decode(String.self,     forKey: .name)
        categoryId    = try c.decode(UUID.self,       forKey: .categoryId)
        description   = try c.decode(String.self,     forKey: .description)
        steps         = try c.decode([GameStep].self, forKey: .steps)
        whatYouNeed   = try c.decode([String].self,   forKey: .whatYouNeed)
        minPlayers    = try c.decode(Int.self,        forKey: .minPlayers)
        maxPlayers    = try c.decode(Int.self,        forKey: .maxPlayers)
        duration      = try c.decode(String.self,     forKey: .duration)
        difficulty    = try c.decode(String.self,     forKey: .difficulty)
        isDrinkingGame = try c.decodeIfPresent(Bool.self, forKey: .isDrinkingGame) ?? false
        isLibraryGame  = try c.decodeIfPresent(Bool.self, forKey: .isLibraryGame)  ?? false
    }

    var playersDisplay: String {
        maxPlayers >= 99 ? "\(minPlayers)+" : "\(minPlayers)–\(maxPlayers)"
    }
}

// MARK: - User Profile

struct UserProfile: Codable {
    var userId: String
    var displayName: String
    var hiddenLibraryGameIds: [UUID]        // library games the user has removed
    var customGames: [Game]                 // games the user added
    var customCategories: [GameCategory]
    var categoryNameOverrides: [UUID: String] // renamed library categories

    init(userId: String, displayName: String) {
        self.userId = userId
        self.displayName = displayName
        self.hiddenLibraryGameIds = []
        self.customGames = []
        self.customCategories = []
        self.categoryNameOverrides = [:]
    }
}
