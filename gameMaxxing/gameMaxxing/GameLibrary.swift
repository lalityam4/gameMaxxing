import Foundation

// Static pre-populated game library. Fixed UUIDs so they're stable across launches.
struct GameLibrary {

    // MARK: - Category IDs
    static let cardGamesId     = UUID(uuidString: "00000001-0000-0000-0000-000000000000")!
    static let mindGamesId     = UUID(uuidString: "00000002-0000-0000-0000-000000000000")!
    static let riddlesId       = UUID(uuidString: "00000003-0000-0000-0000-000000000000")!
    static let wordGamesId     = UUID(uuidString: "00000004-0000-0000-0000-000000000000")!
    static let diceGamesId     = UUID(uuidString: "00000005-0000-0000-0000-000000000000")!
    static let drinkingGamesId = UUID(uuidString: "00000006-0000-0000-0000-000000000000")!
    static let partyGamesId    = UUID(uuidString: "00000007-0000-0000-0000-000000000000")!
    static let appGamesId      = UUID(uuidString: "00000008-0000-0000-0000-000000000000")!
    static let carGamesId      = UUID(uuidString: "00000009-0000-0000-0000-000000000000")!
    static let paperPenId      = UUID(uuidString: "0000000a-0000-0000-0000-000000000000")!

    // MARK: - Categories
    static let categories: [GameCategory] = [
        GameCategory(id: cardGamesId,     name: "Card Games",     emoji: "🃏"),
        GameCategory(id: mindGamesId,     name: "Mind Games",     emoji: "🧠"),
        GameCategory(id: riddlesId,       name: "Riddles",        emoji: "🎭"),
        GameCategory(id: wordGamesId,     name: "Word Games",     emoji: "🗣️"),
        GameCategory(id: diceGamesId,     name: "Dice Games",     emoji: "🎲"),
        GameCategory(id: drinkingGamesId, name: "Drinking Games", emoji: "🍻"),
        GameCategory(id: partyGamesId,    name: "Party Games",    emoji: "🎉"),
        GameCategory(id: appGamesId,      name: "App Games",      emoji: "📱"),
        GameCategory(id: carGamesId,      name: "Car Games",      emoji: "🚗"),
        GameCategory(id: paperPenId,      name: "Paper & Pen",    emoji: "✏️"),
    ]

    // MARK: - Games
    static let games: [Game] = [

        // ── CARD GAMES ────────────────────────────────────────

        Game(
            id: UUID(uuidString: "10000001-0000-0000-0000-000000000000")!,
            name: "Uno Attack",
            categoryId: cardGamesId,
            description: "A chaotic twist on classic Uno. Instead of drawing from a pile, you press a motorized launcher that may or may not blast a pile of cards at you. Expect chaos.",
            steps: [
                GameStep(stepNumber: 1, title: "Load & deal", description: "Shuffle all cards into the launcher. Deal 7 cards to each player face down."),
                GameStep(stepNumber: 2, title: "Flip a starter card", description: "Press the launcher once to reveal the first discard card and place it face-up."),
                GameStep(stepNumber: 3, title: "Match and play", description: "On your turn play a card that matches the top discard by color or number."),
                GameStep(stepNumber: 4, title: "Can't play? Press the launcher", description: "If you have no match, press the launcher button. It may fire zero cards — or a handful. Take whatever comes out."),
                GameStep(stepNumber: 5, title: "Use action cards", description: "Skip, Reverse, Draw Two, and Wild cards change the game. Hit cards send the next player to the launcher."),
                GameStep(stepNumber: 6, title: "Shout UNO!", description: "When you have one card left shout 'UNO!' before the next player takes their turn or you must press the launcher."),
                GameStep(stepNumber: 7, title: "Win", description: "First to empty their hand wins. Score remaining cards in opponents' hands. First to 500 wins the match."),
            ],
            whatYouNeed: ["Uno Attack deck & card launcher", "2× AA batteries", "Table or flat surface"],
            minPlayers: 2, maxPlayers: 10,
            duration: "15–30 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000002-0000-0000-0000-000000000000")!,
            name: "Spoons",
            categoryId: cardGamesId,
            description: "Collect four of a kind and grab a spoon before everyone else. If you're the one left without a spoon, you're out. Gets physical and chaotic fast.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up the spoons", description: "Place one fewer spoon than the number of players in the center of the table. Everyone can reach them."),
                GameStep(stepNumber: 2, title: "Deal 4 cards each", description: "Deal 4 cards to each player. Place the remaining deck beside the dealer."),
                GameStep(stepNumber: 3, title: "Pass left simultaneously", description: "The dealer picks a card from the deck, keeps it or swaps it into their hand, then passes one card face-down to the left. Everyone passes at the same time."),
                GameStep(stepNumber: 4, title: "Collect four of a kind", description: "The moment you have four matching cards, quietly take a spoon from the center."),
                GameStep(stepNumber: 5, title: "Grab a spoon", description: "Once anyone takes a spoon, everyone else must grab one immediately — even if they don't have four of a kind."),
                GameStep(stepNumber: 6, title: "Eliminate", description: "The player left without a spoon gets a letter: S, then P, then O, then N, then S. Spell SPOONS and you're out."),
            ],
            whatYouNeed: ["Standard 52-card deck", "Spoons (one fewer than player count)"],
            minPlayers: 3, maxPlayers: 8,
            duration: "10–20 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000003-0000-0000-0000-000000000000")!,
            name: "Egyptian Rat Screw",
            categoryId: cardGamesId,
            description: "Slap the pile at exactly the right moment to steal the whole stack. Fastest reflexes win. Sandwiches, doubles, and runs trigger the slap.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal all cards", description: "Deal the full deck evenly to all players. Cards are kept face-down in a personal pile."),
                GameStep(stepNumber: 2, title: "Flip and stack", description: "In turn, each player flips the top card of their pile onto a central pile. Do not look at the card before flipping."),
                GameStep(stepNumber: 3, title: "Slap on doubles", description: "If two cards of the same value appear consecutively, slap the pile. First hand on the pile takes all cards."),
                GameStep(stepNumber: 4, title: "Slap on sandwiches", description: "If the same value appears with any one card between them (e.g. 5–9–5), slap the pile."),
                GameStep(stepNumber: 5, title: "Face card challenge", description: "When a face card (J, Q, K, A) is played, the next player must play a face card within 1–4 chances or the challenger takes the pile."),
                GameStep(stepNumber: 6, title: "Win", description: "Collect all 52 cards to win. If you run out of cards you can still slap back in."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 2, maxPlayers: 6,
            duration: "20–40 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000004-0000-0000-0000-000000000000")!,
            name: "Presidents",
            categoryId: cardGamesId,
            description: "Play your cards to climb the social ladder. Be the President, avoid being the Scum. Roles flip each round based on who finishes first.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal all cards", description: "Deal the entire deck evenly to all players. Players sort their hands."),
                GameStep(stepNumber: 2, title: "First round: 3 of Clubs starts", description: "The player holding the 3 of Clubs plays first. They can play any set of cards including that 3."),
                GameStep(stepNumber: 3, title: "Beat or pass", description: "Each player must play a higher card or set of the same count as the last play, or pass. 2s are highest. Suits don't matter."),
                GameStep(stepNumber: 4, title: "Clear the pile", description: "When everyone passes, the last player to play clears the pile and starts fresh."),
                GameStep(stepNumber: 5, title: "Finish and rank", description: "First to empty their hand is President. Second is Vice President. Last two are Vice Scum and Scum."),
                GameStep(stepNumber: 6, title: "Trade cards", description: "Next round: Scum gives their two best cards to President. President gives any two back. Vice positions trade one card."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 4, maxPlayers: 7,
            duration: "30–60 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000005-0000-0000-0000-000000000000")!,
            name: "Crazy Eights",
            categoryId: cardGamesId,
            description: "Get rid of all your cards by matching the suit or number on the discard pile. Eights are wild and let you name the next suit.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal 5 cards each", description: "Deal 5 cards to each player (7 in a 2-player game). Place the rest face-down as the draw pile and flip the top card."),
                GameStep(stepNumber: 2, title: "Match suit or number", description: "Play one card matching the discard's suit or number."),
                GameStep(stepNumber: 3, title: "Play an Eight", description: "Eights are wild — play one any time and call the next suit."),
                GameStep(stepNumber: 4, title: "Draw if you can't play", description: "If you can't play, draw from the pile until you can or until the pile runs out."),
                GameStep(stepNumber: 5, title: "Win", description: "First player to empty their hand wins the round. Score the cards left in opponents' hands (face cards = 10, Aces = 1, Eights = 50)."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 2, maxPlayers: 8,
            duration: "15–25 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000006-0000-0000-0000-000000000000")!,
            name: "Go Fish",
            categoryId: cardGamesId,
            description: "Ask opponents for cards to complete sets of four. If they don't have it, they say 'Go Fish' and you draw from the pond.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal 5–7 cards", description: "Deal 7 cards each for 2–3 players, or 5 cards each for 4 or more. Remaining cards form the draw pile (the pond)."),
                GameStep(stepNumber: 2, title: "Ask for a card", description: "On your turn, ask any player: 'Do you have any [value]?' You must already hold at least one of that value."),
                GameStep(stepNumber: 3, title: "Transfer or Go Fish", description: "If they have the card, they hand it over and you ask again. If not, they say 'Go Fish' — draw one card from the pond."),
                GameStep(stepNumber: 4, title: "Lay down sets of four", description: "When you collect all four cards of a value, place the set face-up in front of you."),
                GameStep(stepNumber: 5, title: "Win", description: "When all cards have been formed into sets, the player with the most sets wins."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 2, maxPlayers: 6,
            duration: "10–15 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        // ── MIND GAMES ─────────────────────────────────────────

        Game(
            id: UUID(uuidString: "20000001-0000-0000-0000-000000000000")!,
            name: "Two Truths & a Lie",
            categoryId: mindGamesId,
            description: "Each person makes three statements about themselves — two true, one false. Everyone else votes on which is the lie. Great for getting to know people.",
            steps: [
                GameStep(stepNumber: 1, title: "Write three statements", description: "Each player privately writes two true things and one lie about themselves. Keep them convincing — the lie should sound plausible."),
                GameStep(stepNumber: 2, title: "Read them out", description: "One at a time, each player reads their three statements aloud in any order."),
                GameStep(stepNumber: 3, title: "Everyone votes", description: "Other players vote on which statement they think is the lie — all at the same time to avoid influence."),
                GameStep(stepNumber: 4, title: "Reveal", description: "The player reveals the lie. Anyone who guessed wrong loses a point. Anyone who guessed right gains one."),
                GameStep(stepNumber: 5, title: "Rotate and repeat", description: "Move to the next player. Play until everyone has gone once."),
            ],
            whatYouNeed: ["Paper and pen (optional)", "Nothing required to play"],
            minPlayers: 3, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "20000002-0000-0000-0000-000000000000")!,
            name: "Never Have I Ever",
            categoryId: mindGamesId,
            description: "Take turns saying things you've never done. Everyone who has done it takes a point (or a sip). Learn way too much about your friends.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up fingers or points", description: "Each player holds up 10 fingers or starts with 10 points."),
                GameStep(stepNumber: 2, title: "Make a statement", description: "One player says 'Never have I ever...' followed by something they have never done."),
                GameStep(stepNumber: 3, title: "Respond", description: "Anyone who has done that thing puts a finger down (or loses a point)."),
                GameStep(stepNumber: 4, title: "Explain (optional)", description: "Players who put a finger down can choose to explain — or keep quiet."),
                GameStep(stepNumber: 5, title: "Rotate and continue", description: "Move clockwise. The first player to lose all 10 fingers or points is out."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 3, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "20000003-0000-0000-0000-000000000000")!,
            name: "Mafia",
            categoryId: mindGamesId,
            description: "An elimination game of hidden roles, deduction, and betrayal. The Mafia secretly eliminate townspeople each night; the Town tries to uncover who the Mafia are during the day.",
            steps: [
                GameStep(stepNumber: 1, title: "Assign roles", description: "A moderator assigns roles secretly: Mafia (roughly 1 per 4 players), Doctor, Detective, and Townspeople. Use cards or slips of paper."),
                GameStep(stepNumber: 2, title: "Night phase", description: "Everyone closes their eyes. Moderator taps Mafia members who silently agree on a victim. Then the Doctor points to someone to save. Then the Detective points to someone to investigate."),
                GameStep(stepNumber: 3, title: "Morning announcement", description: "Everyone opens eyes. Moderator announces who was eliminated (unless the Doctor saved them) without revealing roles."),
                GameStep(stepNumber: 4, title: "Day discussion", description: "Players discuss and accuse. Anyone can argue who they think the Mafia is. No rules — bluff freely."),
                GameStep(stepNumber: 5, title: "Vote and eliminate", description: "Players vote to eliminate one suspect. Majority rules. The eliminated player reveals their role."),
                GameStep(stepNumber: 6, title: "Win condition", description: "Mafia wins when they equal or outnumber the Town. Town wins when all Mafia members are eliminated."),
            ],
            whatYouNeed: ["Role cards or slips of paper", "A moderator who doesn't play"],
            minPlayers: 6, maxPlayers: 20,
            duration: "30–60 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "20000004-0000-0000-0000-000000000000")!,
            name: "Would You Rather",
            categoryId: mindGamesId,
            description: "Pose impossible dilemmas and debate the choices. No right answers — just opinions, arguments, and too much insight into how people think.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up", description: "No setup needed. Sit in a circle and designate who goes first."),
                GameStep(stepNumber: 2, title: "Pose a dilemma", description: "One player asks 'Would you rather [A] or [B]?' Make both options uncomfortable or interesting."),
                GameStep(stepNumber: 3, title: "Everyone answers simultaneously", description: "Count down and everyone points left for A or right for B at the same time."),
                GameStep(stepNumber: 4, title: "Debate", description: "Players on each side argue why their choice is better. No time limit — debate until it's settled."),
                GameStep(stepNumber: 5, title: "Rotate", description: "The next player clockwise poses the next dilemma."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 3, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Easy",
            isLibraryGame: true
        ),

        // ── RIDDLES ────────────────────────────────────────────

        Game(
            id: UUID(uuidString: "30000001-0000-0000-0000-000000000000")!,
            name: "20 Questions",
            categoryId: riddlesId,
            description: "One person thinks of anything — a person, place, or object. The group gets exactly 20 yes-or-no questions to figure it out.",
            steps: [
                GameStep(stepNumber: 1, title: "Think of something", description: "One player secretly thinks of a person, place, animal, or object. Tell no one."),
                GameStep(stepNumber: 2, title: "Announce the category", description: "Say whether it is a person, place, animal, object, or leave it as 'anything'."),
                GameStep(stepNumber: 3, title: "Ask yes/no questions", description: "Players take turns asking one yes-or-no question each. The thinker answers truthfully."),
                GameStep(stepNumber: 4, title: "Track the count", description: "Keep a shared count of questions asked. You only have 20 total."),
                GameStep(stepNumber: 5, title: "Guess or lose", description: "Any player can guess the answer on their turn instead of asking a question. If the group hasn't guessed by question 20, the thinker wins."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 2, maxPlayers: 99,
            duration: "5–15 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "30000002-0000-0000-0000-000000000000")!,
            name: "I Spy",
            categoryId: riddlesId,
            description: "Spot something in the room and give a one-letter clue. Everyone else looks around and guesses what you're thinking of.",
            steps: [
                GameStep(stepNumber: 1, title: "Spot something", description: "One player looks around the room and silently chooses something visible to everyone."),
                GameStep(stepNumber: 2, title: "Give the clue", description: "Say: 'I spy with my little eye, something beginning with [letter].'"),
                GameStep(stepNumber: 3, title: "Guess", description: "Other players take turns guessing objects that start with that letter."),
                GameStep(stepNumber: 4, title: "Confirm or deny", description: "The spy says yes or no to each guess."),
                GameStep(stepNumber: 5, title: "Rotate", description: "Whoever guesses correctly becomes the next spy."),
            ],
            whatYouNeed: ["Nothing — just a shared space"],
            minPlayers: 2, maxPlayers: 99,
            duration: "5–15 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        // ── WORD GAMES ─────────────────────────────────────────

        Game(
            id: UUID(uuidString: "40000001-0000-0000-0000-000000000000")!,
            name: "Word Association",
            categoryId: wordGamesId,
            description: "Say the first word that comes to mind based on the previous word. Hesitate, repeat a word, or say something unrelated and you're out.",
            steps: [
                GameStep(stepNumber: 1, title: "Start with a word", description: "One player says any word to start the chain."),
                GameStep(stepNumber: 2, title: "Respond instantly", description: "The next player immediately says a word associated with the previous one. No pausing to think."),
                GameStep(stepNumber: 3, title: "Keep it moving", description: "Continue around the circle at speed. The association must be obvious enough that the group can see the link."),
                GameStep(stepNumber: 4, title: "Challenge and eliminate", description: "If a player hesitates, repeats a word, or makes a link no one understands, they are out. Group votes on whether a link is acceptable."),
                GameStep(stepNumber: 5, title: "Win", description: "Last player standing wins."),
            ],
            whatYouNeed: ["Nothing"],
            minPlayers: 3, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "40000002-0000-0000-0000-000000000000")!,
            name: "Ghost",
            categoryId: wordGamesId,
            description: "Build a word one letter at a time without completing a real word. The player who finishes a word gets a letter: G-H-O-S-T. Spell GHOST and you're out.",
            steps: [
                GameStep(stepNumber: 1, title: "Start a word", description: "The first player says any single letter to begin building a word."),
                GameStep(stepNumber: 2, title: "Add a letter", description: "Each player adds one letter to the chain. You must have a real word in mind — you cannot play randomly."),
                GameStep(stepNumber: 3, title: "Avoid completing a word", description: "If the letters you've spelled form a complete dictionary word of 4+ letters, you get a letter in GHOST."),
                GameStep(stepNumber: 4, title: "Challenge", description: "If you doubt someone has a real word in mind, challenge them. They must say the word. If they can't, they get a letter. If they can, the challenger gets a letter."),
                GameStep(stepNumber: 5, title: "Spell GHOST and lose", description: "The first player to collect all 5 letters (G-H-O-S-T) is eliminated. Play until one player remains."),
            ],
            whatYouNeed: ["Nothing"],
            minPlayers: 3, maxPlayers: 8,
            duration: "10–20 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "40000003-0000-0000-0000-000000000000")!,
            name: "Categories",
            categoryId: wordGamesId,
            description: "Name things in a given category while keeping a beat. Miss the beat or repeat an answer and you're out.",
            steps: [
                GameStep(stepNumber: 1, title: "Set the beat", description: "Everyone slaps their knees twice then claps twice repeatedly to keep a steady rhythm."),
                GameStep(stepNumber: 2, title: "Name the category", description: "On the clap, one player names a category (e.g. 'Countries in Europe', 'Ice cream flavors')."),
                GameStep(stepNumber: 3, title: "Name something in it", description: "On each subsequent clap, the next player must say something in that category — one word, on the beat."),
                GameStep(stepNumber: 4, title: "No repeats, no hesitation", description: "You cannot repeat an answer already said. If you hesitate past the beat or repeat, you're out."),
                GameStep(stepNumber: 5, title: "Win", description: "Last player still going wins and picks the next category."),
            ],
            whatYouNeed: ["Nothing"],
            minPlayers: 3, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Easy",
            isLibraryGame: true
        ),

        // ── CARD GAMES — NON-DRINKING ──────────────────────────

        Game(
            id: UUID(uuidString: "10000007-0000-0000-0000-000000000000")!,
            name: "Speed",
            categoryId: cardGamesId,
            description: "A lightning-fast 2-player race to get rid of all your cards. No turns — both players play simultaneously until someone runs out.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up the layout", description: "Deal 20 cards to each player. Place 5 in each player's side pile, then deal 1 card face-down to each of the 2 center slots. Each player also gets a 5-card hand from their remaining pile."),
                GameStep(stepNumber: 2, title: "Flip and go", description: "Both players flip the two center cards simultaneously. There are no turns — play as fast as you can."),
                GameStep(stepNumber: 3, title: "Play on center piles", description: "Play a card from your hand onto either center pile if it's one higher or one lower than the top card. Suit doesn't matter. Aces can be high or low."),
                GameStep(stepNumber: 4, title: "Refill your hand", description: "Keep 5 cards in your hand at all times by drawing from your side pile whenever possible."),
                GameStep(stepNumber: 5, title: "Slap in if stuck", description: "If neither player can play, both slap a side pile card onto the center simultaneously to restart."),
                GameStep(stepNumber: 6, title: "Win", description: "First player to play all their cards — hand and side pile — wins."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 2, maxPlayers: 2,
            duration: "5–10 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000008-0000-0000-0000-000000000000")!,
            name: "Trash",
            categoryId: cardGamesId,
            description: "Fill your 10-card layout in order from Ace to 10. Draw cards and place them in the right spot — or pass them along if they don't fit.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal 10 cards face-down", description: "Deal 10 cards face-down to each player in two rows of 5. Number the positions 1–10 in your head (Ace through 10)."),
                GameStep(stepNumber: 2, title: "Draw and place", description: "Draw a card from the deck. If it's an Ace through 10, place it face-up in the matching position and flip the card that was there."),
                GameStep(stepNumber: 3, title: "Chain flips", description: "The flipped card goes to its corresponding position, displacing the next card — chain as long as you can."),
                GameStep(stepNumber: 4, title: "Jacks, Queens, Kings", description: "Jacks and Queens are trash — discard them and your turn ends. Kings are wild and go anywhere."),
                GameStep(stepNumber: 5, title: "Complete your layout", description: "When all 10 positions are filled face-up, you win the round. Next round you only need 9 positions, then 8, and so on."),
                GameStep(stepNumber: 6, title: "Win", description: "First player to complete a 1-card layout (just an Ace) wins the game."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 2, maxPlayers: 4,
            duration: "15–25 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000009-0000-0000-0000-000000000000")!,
            name: "War",
            categoryId: cardGamesId,
            description: "Flip the top card of your deck and whoever plays higher wins both cards. Simple as it gets — but it can go on forever.",
            steps: [
                GameStep(stepNumber: 1, title: "Split the deck", description: "Deal the entire deck face-down, 26 cards each. Players hold their pile face-down."),
                GameStep(stepNumber: 2, title: "Flip and battle", description: "Both players flip their top card simultaneously. Higher card wins both and goes to the bottom of the winner's pile. Ace is highest."),
                GameStep(stepNumber: 3, title: "Declare war on a tie", description: "If both cards are equal, each player places 3 cards face-down and 1 face-up. The higher face-up card takes all 8 cards."),
                GameStep(stepNumber: 4, title: "Keep going", description: "Continue flipping until one player has all 52 cards."),
                GameStep(stepNumber: 5, title: "Win", description: "The player who collects all 52 cards wins. (Feel free to play for a set number of rounds instead.)"),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 2, maxPlayers: 2,
            duration: "20–40 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000010-0000-0000-0000-000000000000")!,
            name: "Rummy",
            categoryId: cardGamesId,
            description: "Draw and discard to build sets (three of a kind) and runs (three in sequence, same suit). First to meld all their cards wins.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal 7 cards", description: "Deal 7 cards to each player (10 for 2 players). Place the remaining deck face-down and flip the top card to start the discard pile."),
                GameStep(stepNumber: 2, title: "Draw", description: "On your turn, draw either the top card from the deck or the top card from the discard pile."),
                GameStep(stepNumber: 3, title: "Meld if you can", description: "Lay down any sets (3+ cards of the same value) or runs (3+ consecutive cards of the same suit) face-up on the table."),
                GameStep(stepNumber: 4, title: "Lay off on melds", description: "You can add cards to existing melds on the table — your own or other players'."),
                GameStep(stepNumber: 5, title: "Discard", description: "End your turn by discarding one card face-up onto the discard pile."),
                GameStep(stepNumber: 6, title: "Win", description: "First player to meld or lay off all their cards wins. Score remaining cards in opponents' hands (face cards = 10, Aces = 1)."),
            ],
            whatYouNeed: ["Standard 52-card deck", "Pen and paper for scoring"],
            minPlayers: 2, maxPlayers: 6,
            duration: "30–60 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000011-0000-0000-0000-000000000000")!,
            name: "Idiot",
            categoryId: cardGamesId,
            description: "Also known as Palace or Shithead. Work through your hand, then your face-up cards, then flip your blind face-down cards. Last one with cards is the Idiot.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up your layout", description: "Deal 3 face-down cards to each player — these are untouchable until the end. Then deal 3 face-up cards on top of them. Finally deal a 3-card hand to each player."),
                GameStep(stepNumber: 2, title: "Swap before starting", description: "Before play begins, players may swap any hand cards with their face-up cards to set themselves up."),
                GameStep(stepNumber: 3, title: "Play from your hand first", description: "Play a card equal to or higher than the top of the central discard pile. 2s reset the pile (play on anything). 10s burn the pile."),
                GameStep(stepNumber: 4, title: "Refill your hand", description: "Always refill your hand to 3 cards from the deck while cards remain. When the deck is gone, play out your hand."),
                GameStep(stepNumber: 5, title: "Move to face-up, then face-down", description: "Once your hand is empty, play from your face-up cards. When those are gone, flip face-down cards one at a time and hope for the best."),
                GameStep(stepNumber: 6, title: "Take the pile if you can't beat it", description: "If you can't play (or flip a face-down card that's too low), take the entire discard pile into your hand."),
                GameStep(stepNumber: 7, title: "Lose", description: "Last player with cards in any form is the Idiot."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 2, maxPlayers: 6,
            duration: "20–40 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000012-0000-0000-0000-000000000000")!,
            name: "Tunk",
            categoryId: cardGamesId,
            description: "A quick knock-rummy variant. Build melds to lower your hand value, then tunk when you think you have the lowest. Get caught with a high hand and you're penalized.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal 5 cards", description: "Deal 5 cards to each player. Flip the top remaining card to start the discard pile."),
                GameStep(stepNumber: 2, title: "Draw and discard", description: "On your turn, draw from the deck or discard pile, then discard one card. Form sets (same value) or runs (consecutive same suit) to reduce your deadwood."),
                GameStep(stepNumber: 3, title: "Tunk to end the round", description: "When you believe your unmelded card total is the lowest at the table, say 'Tunk' and lay down your hand."),
                GameStep(stepNumber: 4, title: "Everyone else reveals", description: "All other players reveal and total their unmelded cards."),
                GameStep(stepNumber: 5, title: "Score", description: "If the tunker has the lowest count, others score their deadwood. If someone ties or beats the tunker, the tunker is penalized double. Face cards = 10, Aces = 1."),
                GameStep(stepNumber: 6, title: "Win", description: "Play to a target score (e.g. 100). Lowest cumulative score wins."),
            ],
            whatYouNeed: ["Standard 52-card deck", "Pen and paper for scoring"],
            minPlayers: 2, maxPlayers: 6,
            duration: "20–40 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000013-0000-0000-0000-000000000000")!,
            name: "Literature",
            categoryId: cardGamesId,
            description: "A team-based set collection game. Ask teammates and opponents for cards to complete half-suits. Only your team can claim a half-suit you think you hold.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up teams and deck", description: "Split into 2 teams of 3 (or 4). Remove the 8s from the deck. The remaining 48 cards form 8 half-suits of 6: Minor (2–7 per suit) and Major (9, 10, J, Q, K, A per suit). Deal all cards evenly."),
                GameStep(stepNumber: 2, title: "Ask for cards", description: "On your turn, ask any opponent for a specific card (e.g. 'Jack, do you have the 3 of Hearts?'). You must already hold a card from that half-suit."),
                GameStep(stepNumber: 3, title: "Transfer or lose your turn", description: "If they have it, they hand it over and you ask again. If not, your turn ends and that player goes next."),
                GameStep(stepNumber: 4, title: "Ask teammates", description: "You can also ask teammates for cards — useful for consolidating a half-suit onto one player."),
                GameStep(stepNumber: 5, title: "Declare a half-suit", description: "When your team believes it holds all 6 cards of a half-suit, any team member declares it by naming where each card is. If correct, your team scores the set."),
                GameStep(stepNumber: 6, title: "Win", description: "The team that claims the most half-suits wins."),
            ],
            whatYouNeed: ["Standard 52-card deck (remove the 8s)"],
            minPlayers: 6, maxPlayers: 12,
            duration: "30–60 min", difficulty: "Hard",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000014-0000-0000-0000-000000000000")!,
            name: "Coup",
            categoryId: cardGamesId,
            description: "Bluff your way to power. Each player has 2 hidden role cards. Take actions as if you hold any role — but if someone calls your bluff and wins, you lose an influence.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal 2 role cards", description: "Shuffle the Coup deck (Duke, Assassin, Captain, Ambassador, Contessa — 3 copies each). Deal 2 face-down to each player. Give everyone 2 coins."),
                GameStep(stepNumber: 2, title: "Take an action", description: "On your turn, take one action: Income (1 coin), Foreign Aid (2 coins, Duke can block), Coup (pay 7 coins, eliminate an influence), or a character action."),
                GameStep(stepNumber: 3, title: "Character actions", description: "Duke: Tax (3 coins). Assassin: Assassinate (pay 3 coins, target loses influence — Contessa blocks). Captain: Steal 2 coins from a player (Ambassador or Captain blocks). Ambassador: Exchange your cards."),
                GameStep(stepNumber: 4, title: "Challenge a bluff", description: "Any player can challenge any action or block. The challenged player reveals their role — if guilty, they lose an influence; if innocent, the challenger loses one."),
                GameStep(stepNumber: 5, title: "Lose influence", description: "When you lose an influence, reveal and discard one role card. Lose both and you're eliminated."),
                GameStep(stepNumber: 6, title: "Win", description: "Last player with at least one influence card wins."),
            ],
            whatYouNeed: ["Coup card game", "Coins or chips for tracking"],
            minPlayers: 2, maxPlayers: 6,
            duration: "15–30 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000015-0000-0000-0000-000000000000")!,
            name: "Golf",
            categoryId: cardGamesId,
            description: "Arrange a 6-card grid and aim for the lowest score. Swap cards strategically over several rounds. Lowest cumulative score after 9 rounds wins.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal a 6-card grid", description: "Deal 6 cards face-down to each player in a 2×3 grid. Flip any 2 cards of your choice face-up to start."),
                GameStep(stepNumber: 2, title: "Draw and swap", description: "On your turn, draw from the deck or discard pile. Swap it with any card in your grid (flip the new card face-up) and discard the replaced card."),
                GameStep(stepNumber: 3, title: "Card values", description: "2s = −2, Aces = 1, face cards = 10, Jokers = 0. Matching pairs in the same column cancel out (score 0 for that column)."),
                GameStep(stepNumber: 4, title: "Knock to end the round", description: "When you think you have the lowest score, knock. All other players get one more turn, then everyone reveals their full grid."),
                GameStep(stepNumber: 5, title: "Penalty for bad knock", description: "If the knocker doesn't have the lowest score, their total is doubled for that round."),
                GameStep(stepNumber: 6, title: "Win", description: "Play 9 rounds (holes). Lowest cumulative score wins. Add a penalty stroke to any unflipped card left at the end of a round."),
            ],
            whatYouNeed: ["Standard 52-card deck (add Jokers)", "Pen and paper for scoring"],
            minPlayers: 2, maxPlayers: 8,
            duration: "20–40 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000016-0000-0000-0000-000000000000")!,
            name: "Red King",
            categoryId: cardGamesId,
            description: "A trick-taking game where the Red Kings are secretly powerful. Avoid taking certain cards or tricks — whoever ends up with the Red Kings pays the price.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal all cards", description: "Deal the entire deck evenly. Players sort their hands. No trump suit."),
                GameStep(stepNumber: 2, title: "Lead a card", description: "The player to the dealer's left leads any card. Others must follow suit if they can; otherwise they may play anything."),
                GameStep(stepNumber: 3, title: "Win the trick", description: "Highest card of the leading suit wins the trick. The winner leads the next trick."),
                GameStep(stepNumber: 4, title: "Track the Red Kings", description: "At the end of the round, check who captured tricks containing the King of Hearts and King of Diamonds. These score penalty points."),
                GameStep(stepNumber: 5, title: "Score", description: "Each Red King captured = 10 penalty points. Other scoring cards can be agreed on before the game (e.g. Queen of Spades)."),
                GameStep(stepNumber: 6, title: "Win", description: "After a set number of rounds, the player with the fewest penalty points wins."),
            ],
            whatYouNeed: ["Standard 52-card deck", "Pen and paper for scoring"],
            minPlayers: 3, maxPlayers: 8,
            duration: "15–30 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000017-0000-0000-0000-000000000000")!,
            name: "Fuck Thy Neighbor",
            categoryId: cardGamesId,
            description: "Also known as Chase the Ace. Everyone gets one card — try not to end up with the lowest. Pass your card to your neighbor before it's too late.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal one card each", description: "Deal one card face-down to each player. Everyone secretly looks at their card without showing others."),
                GameStep(stepNumber: 2, title: "Decide to keep or swap", description: "Starting left of the dealer, each player decides to keep their card or swap it with the neighbor to their left. The neighbor must swap unless they have a King (Kings block all swaps)."),
                GameStep(stepNumber: 3, title: "Dealer draws", description: "The dealer is last. They can keep their card or swap it for a random card from the top of the deck."),
                GameStep(stepNumber: 4, title: "Reveal", description: "Everyone reveals their card simultaneously. Aces are lowest, Kings are highest."),
                GameStep(stepNumber: 5, title: "Lose a life", description: "The player with the lowest card loses a life (start with 3). Ties all lose a life."),
                GameStep(stepNumber: 6, title: "Win", description: "Last player with lives remaining wins."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 3, maxPlayers: 10,
            duration: "10–20 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000018-0000-0000-0000-000000000000")!,
            name: "Cambio",
            categoryId: cardGamesId,
            description: "You have 4 cards and can only peek at 2 of them. Draw and swap strategically to minimize your total. Call 'Cambio' when you think you're lowest — but if you're wrong, you score extra.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal 4 cards", description: "Deal 4 cards face-down to each player in a row. Players may look at the 2 cards closest to them only — memorize them, then place them face-down."),
                GameStep(stepNumber: 2, title: "Draw and decide", description: "On your turn, draw from the deck. You can swap it with any of your 4 cards (even ones you haven't seen) or discard it."),
                GameStep(stepNumber: 3, title: "Special card powers", description: "Some cards have powers when discarded: 7/8 = peek at one of your own cards; 9/10 = peek at an opponent's card; J/Q = swap one of your cards with an opponent's blindly; K = no effect."),
                GameStep(stepNumber: 4, title: "Call Cambio", description: "Instead of drawing, any player can call 'Cambio.' All other players get one final turn, then everyone reveals."),
                GameStep(stepNumber: 5, title: "Score", description: "Total all card values (Ace=1, 2–10 face value, J/Q=10, K=0). The player who called Cambio gets double points if they don't have the lowest total."),
                GameStep(stepNumber: 6, title: "Win", description: "Play to a target score (e.g. 100). Lowest cumulative score wins."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 2, maxPlayers: 8,
            duration: "15–30 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000019-0000-0000-0000-000000000000")!,
            name: "31",
            categoryId: cardGamesId,
            description: "Hold 3 cards and aim for the highest sum in a single suit. Go around the circle swapping cards until someone knocks. Lowest hand drinks or loses a life.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal 3 cards each", description: "Deal 3 cards to each player. Flip one card to start the discard pile. Each player also gets chips or coins to track lives (start with 3)."),
                GameStep(stepNumber: 2, title: "Goal: same suit, high sum", description: "Aim to have 3 cards of the same suit with the highest possible total. Ace = 11, face cards = 10. Three of a kind = 30.5 (beats any suited hand)."),
                GameStep(stepNumber: 3, title: "Take a turn", description: "On your turn, draw the top card from the deck or discard pile, keep it, and discard one of your 3 cards."),
                GameStep(stepNumber: 4, title: "Knock to trigger the final round", description: "Instead of drawing, you can knock. Everyone else gets exactly one more turn, then all hands are revealed."),
                GameStep(stepNumber: 5, title: "Blitz", description: "If you have exactly 31 (Ace + two 10-value cards of the same suit), reveal immediately — everyone else loses a life."),
                GameStep(stepNumber: 6, title: "Lose a life", description: "Player with the lowest hand loses a life (or takes a drink). Knock at the right time — the knocker also loses a life if they don't have the lowest hand."),
            ],
            whatYouNeed: ["Standard 52-card deck", "Chips or coins for lives"],
            minPlayers: 2, maxPlayers: 9,
            duration: "15–30 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000020-0000-0000-0000-000000000000")!,
            name: "Scum",
            categoryId: cardGamesId,
            description: "Play your cards to finish first and claim the throne. The social hierarchy flips every round — President, Vice President, Vice Scum, and Scum trade cards before each game.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal all cards", description: "Deal the entire deck evenly to all players. Players sort their hands. 2s are highest, 3s are lowest."),
                GameStep(stepNumber: 2, title: "First round: lowest card starts", description: "Player with the 3 of Clubs plays first. They play any single card or set of equal-value cards."),
                GameStep(stepNumber: 3, title: "Beat or pass", description: "Each player must play a higher set of the same size, or pass. Once everyone passes, the last player to play clears the pile and leads again."),
                GameStep(stepNumber: 4, title: "Rank up", description: "First to empty their hand is President. Second is Vice President. Second-to-last is Vice Scum. Last is Scum."),
                GameStep(stepNumber: 5, title: "Trade cards next round", description: "Scum gives their 2 best cards to President, who gives back any 2. Vice Scum and Vice President trade 1 card."),
                GameStep(stepNumber: 6, title: "Win", description: "Play as many rounds as desired. The player who holds the President title most often is the overall winner."),
            ],
            whatYouNeed: ["Standard 52-card deck"],
            minPlayers: 4, maxPlayers: 8,
            duration: "30–60 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        // ── CARD GAMES — DRINKING ──────────────────────────────

        Game(
            id: UUID(uuidString: "10000021-0000-0000-0000-000000000000")!,
            name: "Pyramid",
            categoryId: cardGamesId,
            description: "A bluffing drinking game built around a pyramid of face-down cards. When a card is flipped, players claim to have a match and assign drinks — but you can always call their bluff.",
            steps: [
                GameStep(stepNumber: 1, title: "Build the pyramid", description: "Lay cards face-down in a pyramid: 5 cards on the bottom row, then 4, 3, 2, 1 on top. Deal 4 cards face-down to each player — these are your secret hand."),
                GameStep(stepNumber: 2, title: "Know your hand", description: "Look at your cards and memorize them, then place them face-down. You'll claim to have matching cards without showing them."),
                GameStep(stepNumber: 3, title: "Flip pyramid cards", description: "The dealer flips cards row by row, starting from the bottom. Row 1 = 1 drink, Row 2 = 2 drinks, etc. up to 5 at the top."),
                GameStep(stepNumber: 4, title: "Assign drinks on a match", description: "When a card is flipped, any player who claims to have a matching card in their hand may assign drinks equal to that row's value to any player."),
                GameStep(stepNumber: 5, title: "Call a bluff", description: "The assigned player can call a bluff. If the claimer has the matching card, the doubter drinks double. If they were bluffing, the claimer drinks double."),
                GameStep(stepNumber: 6, title: "Finish the pyramid", description: "Continue through all 15 cards. After the pyramid is complete, players must drink for any cards remaining in their hand that were never played."),
            ],
            whatYouNeed: ["Standard 52-card deck", "Drinks"],
            minPlayers: 3, maxPlayers: 8,
            duration: "20–40 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000022-0000-0000-0000-000000000000")!,
            name: "Ride the Bus",
            categoryId: cardGamesId,
            description: "A two-part card drinking game. First, avoid collecting cards in the deal phase. Then the player with the most cards has to ride the bus — a gauntlet of 4 guesses with drinks for each wrong answer.",
            steps: [
                GameStep(stepNumber: 1, title: "Deal phase: round one", description: "The dealer asks each player in turn: 'Red or Black?' Flip a card — wrong answer = drink 1. Right answer = no drink."),
                GameStep(stepNumber: 2, title: "Higher or lower?", description: "Using their first card, each player guesses: 'Higher or Lower?' for the next flip. Wrong = drink 2."),
                GameStep(stepNumber: 3, title: "In between or outside?", description: "Using their two cards, guess if the next card lands between or outside them. Wrong = drink 3."),
                GameStep(stepNumber: 4, title: "Guess the suit", description: "Guess the suit of the next flip (1 in 4 chance). Wrong = drink 4."),
                GameStep(stepNumber: 5, title: "Count cards", description: "After all players have gone through all 4 questions, the player with the most cards in front of them rides the bus."),
                GameStep(stepNumber: 6, title: "Ride the bus", description: "The bus rider repeats the 4 questions from the deck. Each wrong answer = drink that row's value. They keep going until they get all 4 right in a row."),
            ],
            whatYouNeed: ["Standard 52-card deck", "Drinks"],
            minPlayers: 3, maxPlayers: 8,
            duration: "15–30 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000023-0000-0000-0000-000000000000")!,
            name: "Kings Cup",
            categoryId: cardGamesId,
            description: "Draw a card, follow its rule. Every card has a different action. When the 4th King is drawn, whoever drew it must drink the communal Kings Cup in the center.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up", description: "Place a large cup in the center. Spread a full deck face-down around it. Everyone has their own drink."),
                GameStep(stepNumber: 2, title: "Draw and act", description: "Take turns drawing cards. Each card has a rule: Ace = Waterfall (everyone drinks until the person to the right stops), 2 = You pick someone to drink, 3 = You drink, 4 = Everyone touches the floor (last one drinks), 5 = Guys drink, 6 = Girls drink."),
                GameStep(stepNumber: 3, title: "More rules", description: "7 = Heaven (point up — last person drinks), 8 = Pick a Mate who drinks with you all game, 9 = Rhyme (say a word, go around rhyming — first to fail drinks), 10 = Categories (name things in a category — first to fail drinks)."),
                GameStep(stepNumber: 4, title: "Face cards", description: "Jack = Make a new rule that lasts the whole game. Queen = Question master — if you answer a question without asking one back, you drink. King = Pour some of your drink into the Kings Cup."),
                GameStep(stepNumber: 5, title: "The Kings Cup", description: "The first three Kings are just pours. The player who draws the 4th King must drink the entire Kings Cup, ending the game."),
                GameStep(stepNumber: 6, title: "Substitute", description: "Players can substitute any alcoholic drink for a non-alcoholic one at any time."),
            ],
            whatYouNeed: ["Standard 52-card deck", "A large cup for the center", "Drinks"],
            minPlayers: 3, maxPlayers: 99,
            duration: "30–60 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000024-0000-0000-0000-000000000000")!,
            name: "Horse Race",
            categoryId: cardGamesId,
            description: "Bet on an Ace suit and watch the race unfold card by card. The Ace that crosses the finish line first wins the pot — losers drink based on how far their horse fell short.",
            steps: [
                GameStep(stepNumber: 1, title: "Set the track", description: "Line up the 4 Aces face-up in a column (the starting gate). Lay 8 cards face-down in a row beside them — these are the track spaces."),
                GameStep(stepNumber: 2, title: "Place bets", description: "Before the race, each player bets on a suit (Hearts, Diamonds, Clubs, Spades). Bets can be sips, shots, or points."),
                GameStep(stepNumber: 3, title: "Run the race", description: "The dealer flips track cards one by one. When a card is flipped, the Ace matching its suit advances one space up the track."),
                GameStep(stepNumber: 4, title: "Off the track", description: "If an Ace runs off the end of the 8-space track, it falls back to start — and the dealer flips the next face-down track card to add to the course."),
                GameStep(stepNumber: 5, title: "Win the race", description: "The first Ace to reach the finish line wins. Players who bet on that suit win the pot."),
                GameStep(stepNumber: 6, title: "Drink by distance", description: "Losing players drink based on how many spaces short their horse finished. Closer to the finish = fewer sips."),
            ],
            whatYouNeed: ["Standard 52-card deck", "Drinks"],
            minPlayers: 4, maxPlayers: 8,
            duration: "15–30 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000025-0000-0000-0000-000000000000")!,
            name: "Fuck You",
            categoryId: cardGamesId,
            description: "A Pyramid variant with extra attitude. Memorize your cards, then assign drinks as the pyramid is revealed — but bluffing is part of the game, and getting caught costs double.",
            steps: [
                GameStep(stepNumber: 1, title: "Build the grid", description: "Lay out a 5×5 grid of cards face-down. Deal 4 cards to each player to memorize, then place face-down."),
                GameStep(stepNumber: 2, title: "Memorize your hand", description: "Look at your 4 cards carefully, then place them face-down. You'll need to remember them to bluff convincingly."),
                GameStep(stepNumber: 3, title: "Flip grid cards row by row", description: "Flip cards one at a time, row by row. Row 1 = 1 drink assigned, Row 2 = 2, and so on up to Row 5."),
                GameStep(stepNumber: 4, title: "Assign drinks", description: "Any player who claims to have a matching card in their hand may assign drinks worth that row's value to any player."),
                GameStep(stepNumber: 5, title: "Fuck you — call the bluff", description: "The assigned player says 'Fuck you' to challenge. Bluffer revealed = bluffer drinks double. Real match = challenger drinks double."),
                GameStep(stepNumber: 6, title: "End of grid", description: "After all 25 cards, players must drink for any unmatchable cards remaining in their hand. Substitute non-alcoholic drinks freely."),
            ],
            whatYouNeed: ["Standard 52-card deck", "Drinks"],
            minPlayers: 3, maxPlayers: 8,
            duration: "20–40 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "10000026-0000-0000-0000-000000000000")!,
            name: "Cheers to the Governor",
            categoryId: cardGamesId,
            description: "Count to 21 around the circle. When you reach 21, everyone cheers. Then the person who said 21 replaces a number with a new rule. Mess up and you drink.",
            steps: [
                GameStep(stepNumber: 1, title: "Start counting", description: "Sit in a circle. The first person says '1', the next says '2', and so on up to 21. Go at a steady pace."),
                GameStep(stepNumber: 2, title: "Cheer at 21", description: "When someone reaches 21, everyone cheers and drinks. That person then replaces any number in the sequence with a new rule (e.g. 'instead of 7, everyone claps')."),
                GameStep(stepNumber: 3, title: "New rule takes effect", description: "From now on, when the count reaches that number, players must do the action instead of saying the number."),
                GameStep(stepNumber: 4, title: "Mess up = drink", description: "Say the wrong number, forget a rule, hesitate too long, or say a number when you should do an action — you drink and the count resets to 1."),
                GameStep(stepNumber: 5, title: "Keep adding rules", description: "Each time 21 is reached, another number gets replaced. By the end, almost every number is a different action."),
                GameStep(stepNumber: 6, title: "No winner", description: "There's no formal winner — just play until the chaos gets unmanageable or everyone has had enough. Substitute non-alcoholic drinks freely."),
            ],
            whatYouNeed: ["Drinks", "Good memory"],
            minPlayers: 4, maxPlayers: 99,
            duration: "10–20 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        // ── DICE GAMES ─────────────────────────────────────────

        Game(
            id: UUID(uuidString: "50000001-0000-0000-0000-000000000000")!,
            name: "Farkle",
            categoryId: diceGamesId,
            description: "Roll six dice and bank scoring combinations. But if you roll no scoring dice, you Farkle and lose everything accumulated that turn.",
            steps: [
                GameStep(stepNumber: 1, title: "Roll all six dice", description: "On your turn, roll all six dice."),
                GameStep(stepNumber: 2, title: "Set aside scoring dice", description: "Set aside at least one scoring die. 1s = 100pts, 5s = 50pts, three of a kind = number × 100 (three 1s = 1000pts)."),
                GameStep(stepNumber: 3, title: "Roll again or bank", description: "Roll the remaining dice or bank your points. Banking ends your turn and locks in your score."),
                GameStep(stepNumber: 4, title: "Farkle = lose it all", description: "If no dice score on any roll, you Farkle — lose all points accumulated that turn and play passes left."),
                GameStep(stepNumber: 5, title: "Hot dice", description: "If all six dice are scoring, pick them all up and roll again to keep building."),
                GameStep(stepNumber: 6, title: "Win", description: "First player to reach 10,000 points and survive a final round of challenges wins."),
            ],
            whatYouNeed: ["6 standard dice", "Pen and paper for scoring"],
            minPlayers: 2, maxPlayers: 8,
            duration: "20–40 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "50000002-0000-0000-0000-000000000000")!,
            name: "Yahtzee",
            categoryId: diceGamesId,
            description: "Roll five dice up to three times per turn to score specific combinations. Fill your scorecard in 13 rounds. Highest total wins.",
            steps: [
                GameStep(stepNumber: 1, title: "Roll all five dice", description: "On your turn, roll all five dice to start."),
                GameStep(stepNumber: 2, title: "Keep and re-roll", description: "Set aside any dice you want to keep. Roll the rest. You can re-roll up to twice more per turn."),
                GameStep(stepNumber: 3, title: "Choose a scoring category", description: "After your final roll, mark one category on your scorecard. You must fill one category per turn even if it scores zero."),
                GameStep(stepNumber: 4, title: "Score combinations", description: "Upper section: sum of each number (1s through 6s). Lower section: Three of a Kind, Four of a Kind, Full House (25), Small Straight (30), Large Straight (40), Chance, Yahtzee (50)."),
                GameStep(stepNumber: 5, title: "Yahtzee bonus", description: "If you roll a Yahtzee and have already scored it, mark a bonus 100 points on the back of the card."),
                GameStep(stepNumber: 6, title: "Win", description: "After 13 rounds all categories are filled. Add up totals — bonus 35 points if upper section totals 63+. Highest score wins."),
            ],
            whatYouNeed: ["5 dice", "Yahtzee scorecard (or paper)", "Pen"],
            minPlayers: 2, maxPlayers: 6,
            duration: "30–45 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "50000003-0000-0000-0000-000000000000")!,
            name: "Liar's Dice",
            categoryId: diceGamesId,
            description: "Roll your dice in secret and bluff your way through bids on what everyone has. Call someone a liar — or get called out yourself. Lose a die each time you're wrong. Last player with dice wins.",
            steps: [
                GameStep(stepNumber: 1, title: "Roll in secret", description: "Each player rolls their 5 dice under a cup and looks at them without showing anyone else."),
                GameStep(stepNumber: 2, title: "Make a bid", description: "The first player bids on how many dice of a certain face value exist across all players' dice combined. For example: 'three fours' means at least 3 dice total show a 4."),
                GameStep(stepNumber: 3, title: "Ones are wild", description: "1s count as any face value. A die showing a 1 contributes to any bid, regardless of the called number."),
                GameStep(stepNumber: 4, title: "Raise the bid", description: "Each new bid must be higher than the last — either a higher quantity (same or any value) or the same quantity with a higher face value. You can never bid lower."),
                GameStep(stepNumber: 5, title: "Call the bluff", description: "Instead of bidding, say 'Liar!' to challenge the previous bid. All players lift their cups to reveal their dice."),
                GameStep(stepNumber: 6, title: "Resolve the challenge", description: "Count all dice showing the bid value (plus all 1s). If the count meets or exceeds the bid, the caller loses a die. If the count falls short, the bidder loses a die."),
                GameStep(stepNumber: 7, title: "Win", description: "A player eliminated when they lose their last die. Last player with any dice remaining wins."),
            ],
            whatYouNeed: ["5 dice per player", "A cup per player to hide dice"],
            minPlayers: 2, maxPlayers: 6,
            duration: "15–30 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        // ── DRINKING GAMES (NON-CARD) ──────────────────────────

        Game(
            id: UUID(uuidString: "60000001-0000-0000-0000-000000000000")!,
            name: "Beer Pong",
            categoryId: drinkingGamesId,
            description: "Throw a ping pong ball across the table and try to land it in the opposing team's cups. Sink a cup, they drink it. Clear their side first to win.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up", description: "Arrange 10 cups in a triangle formation on each end of a long table. Fill each cup with a small amount of beer (or any drink). Each team stands at their end."),
                GameStep(stepNumber: 2, title: "Shoot", description: "Teams take turns throwing a ping pong ball toward the opponent's cups. Each team gets 2 shots per turn (one per player). Elbows must stay behind the table edge."),
                GameStep(stepNumber: 3, title: "Drink and remove", description: "When a ball lands in a cup, the opposing team drinks it and removes the cup from the table."),
                GameStep(stepNumber: 4, title: "Re-racks", description: "Each team can request 2 re-racks per game — rearranging remaining cups into a tighter formation."),
                GameStep(stepNumber: 5, title: "Redemption", description: "When the last cup is sunk, the losing team gets a redemption round — they shoot until they miss. If they clear the remaining cups, the game goes to overtime with 3 cups each."),
                GameStep(stepNumber: 6, title: "Win", description: "First team to eliminate all of the opponent's cups wins. Substitute non-alcoholic drinks freely."),
            ],
            whatYouNeed: ["20 solo cups", "2 ping pong balls", "A long table", "Drinks"],
            minPlayers: 4, maxPlayers: 4,
            duration: "20–40 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "60000002-0000-0000-0000-000000000000")!,
            name: "Up Chicken Down Chicken",
            categoryId: drinkingGamesId,
            description: "A quarter bouncing game with two commands. Bounce a quarter into a cup. The person across from you either drinks up or drinks down depending on the call.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up", description: "Sit in a circle. Place a cup in the center with a small amount of drink. One player starts with a quarter."),
                GameStep(stepNumber: 2, title: "Bounce the quarter", description: "The active player bounces the quarter off the table, trying to land it in the cup."),
                GameStep(stepNumber: 3, title: "Make the call", description: "Before bouncing, the player says 'Up Chicken' or 'Down Chicken.' Up = the person to their left must drink if it lands. Down = the person to their right."),
                GameStep(stepNumber: 4, title: "Miss = pass", description: "If the quarter misses, the quarter passes to the left. No drinks on a miss."),
                GameStep(stepNumber: 5, title: "Land it = drink", description: "If the quarter lands in the cup, the designated 'chicken' must drink and the shooter goes again."),
                GameStep(stepNumber: 6, title: "Keep going", description: "Play continues until everyone has had their fill. Substitute non-alcoholic drinks freely."),
            ],
            whatYouNeed: ["A quarter", "Solo cups", "Drinks"],
            minPlayers: 3, maxPlayers: 10,
            duration: "15–30 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "60000003-0000-0000-0000-000000000000")!,
            name: "7/11 or Doubles",
            categoryId: drinkingGamesId,
            description: "Roll two dice. If you get 7, 11, or doubles, someone drinks — but they have to pick up the cup before you re-roll. Race the dice every single turn.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up", description: "Fill a cup with a drink and place it in the center of the table. One player starts with the dice."),
                GameStep(stepNumber: 2, title: "Roll", description: "The active player rolls both dice. If the result is 7, 11, or any doubles, they point to someone who must drink."),
                GameStep(stepNumber: 3, title: "Pick up and race", description: "The chosen player picks up the cup and starts drinking. The roller immediately re-rolls as fast as possible."),
                GameStep(stepNumber: 4, title: "Put it down to stop", description: "The drinker can only stop when the cup is back on the table. But if the roller hits 7, 11, or doubles again before the cup is down, the drinker must drink more."),
                GameStep(stepNumber: 5, title: "Pass the dice", description: "Once the cup is back on the table, the dice pass to the left. If the roller misses (no 7, 11, or doubles), dice pass immediately."),
                GameStep(stepNumber: 6, title: "Keep playing", description: "Continue until everyone's had enough. Substitute non-alcoholic drinks freely."),
            ],
            whatYouNeed: ["2 dice", "A cup", "Drinks"],
            minPlayers: 3, maxPlayers: 8,
            duration: "Open-ended", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "60000004-0000-0000-0000-000000000000")!,
            name: "Beer Ball",
            categoryId: drinkingGamesId,
            description: "Two teams race to finish their beers. Throw a ping pong ball at the opposing team's cans — when you hit one, chug until they retrieve the ball and tap the table.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up", description: "Two teams of 2 face each other across a table. Each player places their unopened can in front of them at the table edge."),
                GameStep(stepNumber: 2, title: "Throw the ball", description: "Teams alternate throwing a ping pong ball at the opposing team's cans. You're aiming to hit the cans."),
                GameStep(stepNumber: 3, title: "Hit a can — chug", description: "When a can is hit, that player opens it (or picks it up if already open) and chugs continuously while the other team retrieves the ball."),
                GameStep(stepNumber: 4, title: "Stop chugging", description: "The chugging stops the moment the throwing team retrieves the ball and one player taps it on the table."),
                GameStep(stepNumber: 5, title: "Miss = no drink", description: "If the throw misses all cans, no one drinks and the other team throws."),
                GameStep(stepNumber: 6, title: "Win", description: "First team to finish both of their cans wins. Substitute non-alcoholic drinks freely."),
            ],
            whatYouNeed: ["4 cans of beer (or canned drinks)", "1 ping pong ball", "A table"],
            minPlayers: 4, maxPlayers: 4,
            duration: "20–40 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "60000005-0000-0000-0000-000000000000")!,
            name: "Musical Flip Cup",
            categoryId: drinkingGamesId,
            description: "Flip cup meets musical chairs. When the music stops, two players face off in a flip cup duel. Loser is eliminated. Last one standing wins.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up", description: "Fill cups halfway with drink and arrange them in a circle around a table — one cup fewer than the number of players. Everyone stands around the table."),
                GameStep(stepNumber: 2, title: "Music plays, walk around", description: "Play music. Players walk around the table. When the music stops, everyone rushes to grab a cup."),
                GameStep(stepNumber: 3, title: "Flip cup duel", description: "The one player left without a cup must flip cup against their nearest neighbor. Each drinks then flips their cup from the table edge using one finger."),
                GameStep(stepNumber: 4, title: "Loser is eliminated", description: "First to flip successfully wins. Loser is out and one more cup is removed."),
                GameStep(stepNumber: 5, title: "Repeat", description: "Restart the music. Keep going until two players remain."),
                GameStep(stepNumber: 6, title: "Final showdown", description: "Final two players do a best-of-3 flip cup duel. Winner takes the game. Substitute non-alcoholic drinks freely."),
            ],
            whatYouNeed: ["Solo cups", "Music source", "Drinks"],
            minPlayers: 6, maxPlayers: 99,
            duration: "15–30 min", difficulty: "Easy",
            isDrinkingGame: true, isLibraryGame: true
        ),

        // ── PARTY GAMES ────────────────────────────────────────

        Game(
            id: UUID(uuidString: "70000001-0000-0000-0000-000000000000")!,
            name: "Couch Game",
            categoryId: partyGamesId,
            description: "Two teams compete to fill the couch. One team is on the couch, one is on the floor. Say a teammate's name and they swap seats — but the other team is trying to block you.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up teams", description: "Split into 2 equal teams. One team sits on the couch with one empty seat next to them. The other team sits on the floor or chairs nearby."),
                GameStep(stepNumber: 2, title: "Fill the empty seat", description: "The team on the couch tries to fill the empty seat by calling a teammate's name. That teammate immediately moves to the empty seat."),
                GameStep(stepNumber: 3, title: "Blocking", description: "The floor team tries to sit in the empty seat before the named couch player can move. If they succeed, they take the seat and a floor player is now on the couch."),
                GameStep(stepNumber: 4, title: "Keep moving", description: "Calling a name always creates a new empty seat where the named player was sitting. Both teams react simultaneously."),
                GameStep(stepNumber: 5, title: "Win", description: "The couch team wins when all their players are on the couch. The floor team wins if they take over the couch entirely."),
            ],
            whatYouNeed: ["A couch", "Chairs or floor space"],
            minPlayers: 6, maxPlayers: 20,
            duration: "20–40 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "70000002-0000-0000-0000-000000000000")!,
            name: "Do You Like Your Neighbors",
            categoryId: partyGamesId,
            description: "One person stands in the middle and asks someone 'Do you like your neighbors?' Say no and chaos breaks out. A deceptively simple game that gets wild fast.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up", description: "Sit in a circle with chairs, one per person. One person stands in the middle with no chair."),
                GameStep(stepNumber: 2, title: "Ask a neighbor question", description: "The middle person asks anyone: 'Do you like your neighbors?' The answer determines what happens next."),
                GameStep(stepNumber: 3, title: "Yes — neighbors swap", description: "If you say 'Yes,' your two immediate neighbors must swap seats. The middle person tries to steal one of those seats."),
                GameStep(stepNumber: 4, title: "No — everyone with [trait] moves", description: "If you say 'No,' you say who you do like — e.g., 'I like people who are wearing blue.' Everyone fitting that description must stand up and find a new seat. No sitting back down in the same seat. Middle person also grabs a seat."),
                GameStep(stepNumber: 5, title: "New middle person", description: "Whoever doesn't get a seat becomes the new middle person."),
            ],
            whatYouNeed: ["Chairs (one fewer than players)"],
            minPlayers: 5, maxPlayers: 20,
            duration: "10–20 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "70000003-0000-0000-0000-000000000000")!,
            name: "Kingdom / Empire",
            categoryId: partyGamesId,
            description: "Write a famous person's name on a sticky note and put it on someone else's forehead. Ask yes/no questions to figure out who you are.",
            steps: [
                GameStep(stepNumber: 1, title: "Write names", description: "Each player writes the name of a famous person (real or fictional) on a sticky note or piece of paper."),
                GameStep(stepNumber: 2, title: "Stick it on someone else", description: "Pass your note to another player who sticks it on their forehead without looking. Everyone can see your name except you."),
                GameStep(stepNumber: 3, title: "Ask yes/no questions", description: "Take turns asking the group yes/no questions to narrow down who you are. 'Am I alive?' 'Am I in sports?' 'Am I American?'"),
                GameStep(stepNumber: 4, title: "Correct guess = go again", description: "If you guess correctly, you can remove your note and keep asking questions to try to guess a second identity (or just relax and help others)."),
                GameStep(stepNumber: 5, title: "Win", description: "First player to correctly guess their identity wins. Or play until everyone has figured theirs out."),
            ],
            whatYouNeed: ["Sticky notes or paper", "Pens", "Something to stick notes to foreheads (tape or sticky notes)"],
            minPlayers: 4, maxPlayers: 20,
            duration: "20–40 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "70000004-0000-0000-0000-000000000000")!,
            name: "Signs",
            categoryId: partyGamesId,
            description: "Everyone has a secret sign. One person is 'it' and tries to catch the sign being passed around the circle before it gets to them.",
            steps: [
                GameStep(stepNumber: 1, title: "Assign signs", description: "Everyone in the circle picks a unique physical gesture (tapping nose, pulling ear, wink, etc.). Go around and learn each other's signs."),
                GameStep(stepNumber: 2, title: "It stands in the middle", description: "One player stands in the center. They close their eyes while the group silently picks who starts with the signal."),
                GameStep(stepNumber: 3, title: "Pass the signal", description: "Players pass the signal by making eye contact with someone and doing their sign. The recipient acknowledges with their own sign back, then becomes the new signal holder."),
                GameStep(stepNumber: 4, title: "It tries to catch it", description: "The middle player watches for the passing signal. If they see someone performing a sign, they can accuse that player."),
                GameStep(stepNumber: 5, title: "Caught or guessed wrong", description: "If the accusation is correct, the caught player goes to the middle. If wrong, the accuser must do a penalty (or just continue watching)."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 5, maxPlayers: 20,
            duration: "15–30 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "70000005-0000-0000-0000-000000000000")!,
            name: "Blind Never Have I Ever",
            categoryId: partyGamesId,
            description: "Like Never Have I Ever, but everyone puts fingers down secretly and simultaneously — no one has to admit what they've done. Then you reveal and compare.",
            steps: [
                GameStep(stepNumber: 1, title: "Hold up fingers", description: "Everyone holds up 5 fingers (or 10) hidden from view behind their back or under the table."),
                GameStep(stepNumber: 2, title: "Make a statement", description: "One player says 'Never have I ever...' followed by something they've never done."),
                GameStep(stepNumber: 3, title: "Put fingers down secretly", description: "Anyone who has done that thing puts a finger down without showing anyone."),
                GameStep(stepNumber: 4, title: "Reveal simultaneously", description: "After each statement, everyone reveals their current finger count at the same time on a count of 3."),
                GameStep(stepNumber: 5, title: "React and rotate", description: "See who put a finger down and react accordingly — but no one has to explain themselves. Player with the fewest fingers left after all statements is the 'most experienced.'"),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 4, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "70000006-0000-0000-0000-000000000000")!,
            name: "Vollines",
            categoryId: partyGamesId,
            description: "A beach game played in a square divided by a center line. Throw a tennis ball to the other side — the receiving team must catch it before it bounces twice. Fast, fun, and surprisingly intense.",
            steps: [
                GameStep(stepNumber: 1, title: "Draw the court", description: "Mark out a square divided down the middle by a line (draw in sand or use tape/rope on grass). Teams stand on opposite sides."),
                GameStep(stepNumber: 2, title: "Serve", description: "One team starts by throwing the tennis ball over the center line to the other side."),
                GameStep(stepNumber: 3, title: "Receive", description: "The receiving team must catch the ball before it bounces twice on their side. One bounce is allowed."),
                GameStep(stepNumber: 4, title: "Throw back", description: "After catching, throw it back over the line. Keep it within the square boundaries."),
                GameStep(stepNumber: 5, title: "Score a point", description: "Score a point if the ball bounces twice on the opponent's side, goes out of bounds on their side, or they drop it on a valid throw."),
                GameStep(stepNumber: 6, title: "Win", description: "First team to 11 points (win by 2) wins. Best of 3 sets recommended."),
            ],
            whatYouNeed: ["A tennis ball", "Open space (beach, grass, or gym)", "Something to mark a square court"],
            minPlayers: 4, maxPlayers: 8,
            duration: "15–30 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "70000007-0000-0000-0000-000000000000")!,
            name: "I Like People Who…",
            categoryId: partyGamesId,
            description: "One person in the middle calls out a trait. Everyone who fits that description scrambles for a new seat — and so does the caller. Whoever doesn't find a seat is next.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up", description: "Sit in a circle with chairs, one fewer than the number of players. One player starts in the middle."),
                GameStep(stepNumber: 2, title: "Make a statement", description: "The middle player says 'I like people who...' followed by any trait: 'have a dog,' 'are wearing socks,' 'have been to Europe,' etc."),
                GameStep(stepNumber: 3, title: "Everyone who fits it moves", description: "Anyone who fits the description must stand up and find a new seat. They cannot sit back in their original seat."),
                GameStep(stepNumber: 4, title: "Grab a seat", description: "The middle player also rushes to grab a seat. Whoever is left standing becomes the new middle person."),
                GameStep(stepNumber: 5, title: "Keep going", description: "Play as many rounds as you like. The more creative the prompts, the more fun it gets."),
            ],
            whatYouNeed: ["Chairs (one fewer than players)"],
            minPlayers: 5, maxPlayers: 20,
            duration: "15–30 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        // ── APP GAMES ──────────────────────────────────────────

        Game(
            id: UUID(uuidString: "80000001-0000-0000-0000-000000000000")!,
            name: "Psych!",
            categoryId: appGamesId,
            description: "The app asks trivia questions and everyone submits a fake-but-believable answer. Then vote for the real answer among all the fakes. Fool people to score points.",
            steps: [
                GameStep(stepNumber: 1, title: "Download the app", description: "Download the Psych! app (by Ellen DeGeneres). One player creates a game room and others join with a room code."),
                GameStep(stepNumber: 2, title: "Pick a category", description: "The host selects a trivia category (Movie Taglines, Celebrities, History, etc.)."),
                GameStep(stepNumber: 3, title: "Submit a fake answer", description: "The app shows a real trivia question. Every player submits a fake answer designed to sound believable."),
                GameStep(stepNumber: 4, title: "Vote for the real answer", description: "All fake answers (plus the real one) are shown. Players vote for what they think is correct."),
                GameStep(stepNumber: 5, title: "Score", description: "You score points for every player you fooled with your fake answer, plus bonus points if you correctly identified the real answer."),
                GameStep(stepNumber: 6, title: "Win", description: "Play through the round. Player with the most points after all questions wins."),
            ],
            whatYouNeed: ["Psych! app (free, iOS & Android)", "1 phone per player"],
            minPlayers: 3, maxPlayers: 8,
            duration: "15–30 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "80000002-0000-0000-0000-000000000000")!,
            name: "Piccolo",
            categoryId: appGamesId,
            description: "A drinking game app that delivers prompts, dares, and mini-games one player at a time. The app knows everyone's names and makes it personal.",
            steps: [
                GameStep(stepNumber: 1, title: "Download and enter names", description: "Download the Piccolo app. Enter the names of all players — the app uses them throughout."),
                GameStep(stepNumber: 2, title: "Pick a game mode", description: "Choose from modes like Classic, Dirty, Party, or create a custom mix depending on your group's vibe."),
                GameStep(stepNumber: 3, title: "Pass the phone", description: "Pass the phone around the circle. The person holding it reads their prompt aloud and follows it."),
                GameStep(stepNumber: 4, title: "Follow the prompt", description: "Prompts range from drinking rules and dares to mini-games and group challenges. The app handles the pacing."),
                GameStep(stepNumber: 5, title: "Keep going", description: "Continue passing until the game ends or everyone decides to stop. Substitute non-alcoholic drinks freely."),
            ],
            whatYouNeed: ["Piccolo app (iOS & Android)", "1 phone", "Drinks (optional)"],
            minPlayers: 3, maxPlayers: 10,
            duration: "Open-ended", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "80000003-0000-0000-0000-000000000000")!,
            name: "Mr. White",
            categoryId: appGamesId,
            description: "Almost everyone gets a secret word. One player — Mr. White — gets nothing. Describe your word without saying it. Mr. White bluffs. The group tries to unmask the imposter.",
            steps: [
                GameStep(stepNumber: 1, title: "Download and start a game", description: "Download the Mr. White app. Everyone gets dealt a secret word — except Mr. White, who sees a blank screen."),
                GameStep(stepNumber: 2, title: "Give one clue", description: "Go around the circle. Each player says one word or phrase to hint at their secret word without saying it. Mr. White improvises."),
                GameStep(stepNumber: 3, title: "Discuss and vote", description: "After one full round of clues, players discuss who they think is Mr. White and vote to eliminate someone."),
                GameStep(stepNumber: 4, title: "Mr. White guesses", description: "If Mr. White is eliminated, they get one final chance to guess the secret word. If correct, Mr. White wins."),
                GameStep(stepNumber: 5, title: "Win condition", description: "Citizens win by correctly eliminating Mr. White before he guesses the word. Mr. White wins by surviving until only 3 players remain or by guessing the word after being caught."),
            ],
            whatYouNeed: ["Mr. White app (iOS & Android)"],
            minPlayers: 4, maxPlayers: 20,
            duration: "15–30 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "80000004-0000-0000-0000-000000000000")!,
            name: "Wikiraces",
            categoryId: appGamesId,
            description: "Start on one Wikipedia page and race to reach a target page using only internal hyperlinks. Whoever navigates there in the fewest clicks wins.",
            steps: [
                GameStep(stepNumber: 1, title: "Pick start and end articles", description: "Agree on a starting Wikipedia article and a target article. The more unrelated they seem, the better."),
                GameStep(stepNumber: 2, title: "Everyone starts on the same page", description: "All players navigate to the start article on their device simultaneously."),
                GameStep(stepNumber: 3, title: "Race to the target", description: "Click through Wikipedia's internal links to reach the target page. You can only use links within article text — no search bar, no back button (or agree on rules before starting)."),
                GameStep(stepNumber: 4, title: "Announce your win", description: "First player to reach the target article calls out and shows their screen."),
                GameStep(stepNumber: 5, title: "Compare paths", description: "Everyone shares the path they took. The person with the fewest clicks wins the tiebreaker if multiple players finish close together."),
            ],
            whatYouNeed: ["A phone or browser per player", "Wikipedia access"],
            minPlayers: 2, maxPlayers: 99,
            duration: "5–15 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "80000005-0000-0000-0000-000000000000")!,
            name: "Out of the Loop",
            categoryId: appGamesId,
            description: "Most players get the same secret word. One player — out of the loop — gets nothing. Ask each other questions and try to identify who doesn't know the word.",
            steps: [
                GameStep(stepNumber: 1, title: "Start a round", description: "Download the Out of the Loop app. One player starts a round — most players receive a secret word, one player sees 'You are out of the loop.'"),
                GameStep(stepNumber: 2, title: "Ask and answer", description: "Take turns asking each other questions about the word. Keep answers vague enough to not give it away to the outsider."),
                GameStep(stepNumber: 3, title: "The outsider bluffs", description: "The player out of the loop must answer questions confidently, guessing from context what the word might be."),
                GameStep(stepNumber: 4, title: "Vote", description: "After a set number of questions, everyone simultaneously votes on who they think is out of the loop."),
                GameStep(stepNumber: 5, title: "Outsider guesses", description: "If the outsider is voted out, they get one guess at the secret word. Guess correctly and they still win."),
                GameStep(stepNumber: 6, title: "Score", description: "Outsider wins by surviving or guessing right. Everyone else wins by correctly identifying the outsider."),
            ],
            whatYouNeed: ["Out of the Loop app (iOS & Android)"],
            minPlayers: 4, maxPlayers: 20,
            duration: "15–30 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        // ── CAR GAMES ──────────────────────────────────────────

        Game(
            id: UUID(uuidString: "90000001-0000-0000-0000-000000000000")!,
            name: "License Plate Game",
            categoryId: carGamesId,
            description: "Spot license plates from different states or countries during a road trip and call them out. First to find all 50 states wins — or just compete to find the most.",
            steps: [
                GameStep(stepNumber: 1, title: "Set the goal", description: "Decide the objective before starting: find all 50 US states, find the most plates in a set time, or collect the most unusual/distant plates."),
                GameStep(stepNumber: 2, title: "Spot and call", description: "Any player can spot a license plate from a different state (or country) and call it out. First to call it claims it."),
                GameStep(stepNumber: 3, title: "Track your finds", description: "Keep a running list on paper or in a notes app. Each unique state or country counts once."),
                GameStep(stepNumber: 4, title: "No double-counting", description: "Once a state has been claimed by someone, it can't be claimed again — or play cooperatively and let everyone share the list."),
                GameStep(stepNumber: 5, title: "Win", description: "At the end of the trip, the player with the most unique plates wins. Bonus points for Hawaii, Alaska, or international plates."),
            ],
            whatYouNeed: ["A moving vehicle", "Pen and paper or notes app (optional)"],
            minPlayers: 2, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Easy",
            isLibraryGame: true
        ),

        // ── PAPER & PEN ────────────────────────────────────────

        Game(
            id: UUID(uuidString: "a0000001-0000-0000-0000-000000000000")!,
            name: "Ultimate Tic Tac Toe",
            categoryId: paperPenId,
            description: "A Tic Tac Toe game played inside another Tic Tac Toe grid. Where you play in a small square determines where your opponent must play next. Win 3 small grids in a row to win.",
            steps: [
                GameStep(stepNumber: 1, title: "Draw the board", description: "Draw a large 3×3 grid. Inside each of the 9 cells, draw another 3×3 grid. You now have 81 small squares total."),
                GameStep(stepNumber: 2, title: "First move anywhere", description: "The first player places their mark (X or O) in any small square within any of the 9 mini-grids."),
                GameStep(stepNumber: 3, title: "Your move determines their zone", description: "The cell position where you played inside the mini-grid corresponds to a mini-grid on the outer board. Your opponent must play inside that mini-grid on their turn."),
                GameStep(stepNumber: 4, title: "Win a mini-grid", description: "Win a mini-grid by getting 3 in a row within it. Mark that mini-grid with your symbol on the outer board."),
                GameStep(stepNumber: 5, title: "Sent to a won grid", description: "If you're sent to a mini-grid that's already been won or filled, your opponent can play anywhere."),
                GameStep(stepNumber: 6, title: "Win", description: "Win 3 mini-grids in a row on the outer board to win the game."),
            ],
            whatYouNeed: ["Paper", "Pen"],
            minPlayers: 2, maxPlayers: 2,
            duration: "10–20 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "a0000002-0000-0000-0000-000000000000")!,
            name: "Lasso",
            categoryId: paperPenId,
            description: "A territory game on a dot grid. Draw lines to form complete circles (lassos) around dots. Each completed lasso scores the dots inside. Most territory wins.",
            steps: [
                GameStep(stepNumber: 1, title: "Draw a dot grid", description: "Draw a grid of dots — 6×6 or larger works well. Players alternate turns."),
                GameStep(stepNumber: 2, title: "Connect adjacent dots", description: "On your turn, draw one line segment connecting two adjacent dots (horizontally or vertically). Diagonal lines are not allowed."),
                GameStep(stepNumber: 3, title: "Close a lasso", description: "If your line completes a closed loop around one or more dots, those dots are yours. Fill them in or mark them with your symbol."),
                GameStep(stepNumber: 4, title: "Extra turn on capture", description: "Whenever you close a loop, take another turn immediately."),
                GameStep(stepNumber: 5, title: "Win", description: "When no more lines can be drawn, count the dots inside each player's lassos. Most dots wins."),
            ],
            whatYouNeed: ["Graph paper or blank paper", "Pen"],
            minPlayers: 2, maxPlayers: 2,
            duration: "10–20 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "a0000003-0000-0000-0000-000000000000")!,
            name: "Sim",
            categoryId: paperPenId,
            description: "Two players draw colored lines between 6 dots. The player who completes a triangle of their own color loses. Sounds simple — the math guarantees one of you will lose.",
            steps: [
                GameStep(stepNumber: 1, title: "Draw 6 dots in a circle", description: "Draw 6 dots arranged in a rough hexagon or circle on paper. These are the game's nodes."),
                GameStep(stepNumber: 2, title: "Assign colors", description: "Each player picks a color (or one draws with pen, the other with pencil)."),
                GameStep(stepNumber: 3, title: "Draw a line", description: "On your turn, draw a line connecting any two dots that don't yet have a line between them. Use your color."),
                GameStep(stepNumber: 4, title: "Avoid triangles", description: "Do not complete a triangle where all 3 sides are your color. The player who completes such a triangle loses that round."),
                GameStep(stepNumber: 5, title: "Win", description: "Play multiple rounds. First to lose 3 rounds loses the match. Note: by mathematical necessity, every game will end in a triangle — it's just a question of whose."),
            ],
            whatYouNeed: ["Paper", "2 different colored pens or pen + pencil"],
            minPlayers: 2, maxPlayers: 2,
            duration: "5–15 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "a0000004-0000-0000-0000-000000000000")!,
            name: "Bridges",
            categoryId: paperPenId,
            description: "Draw islands and build bridges between them. Create a connected network — but watch out, because your opponent is trying to cut your path.",
            steps: [
                GameStep(stepNumber: 1, title: "Draw the islands", description: "Take turns drawing small circles (islands) randomly across the paper — about 10–15 total. Each island can hold a limited number of bridges (write the max inside: 1–4)."),
                GameStep(stepNumber: 2, title: "Build bridges", description: "On your turn, draw a line (bridge) between two islands that still have bridge capacity. Bridges must be straight (horizontal, vertical, or diagonal) and cannot cross each other."),
                GameStep(stepNumber: 3, title: "Double bridges", description: "Two bridges can run parallel between the same pair of islands (counts as 2 toward their capacity)."),
                GameStep(stepNumber: 4, title: "Connect everything", description: "The goal is to connect all islands into one fully connected network where you can travel from any island to any other island via bridges."),
                GameStep(stepNumber: 5, title: "Win", description: "The player who places the bridge that creates the fully connected network wins. If no valid bridges remain and islands are still isolated, work together to try again."),
            ],
            whatYouNeed: ["Paper", "Pen"],
            minPlayers: 2, maxPlayers: 2,
            duration: "10–20 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "a0000005-0000-0000-0000-000000000000")!,
            name: "NIM",
            categoryId: paperPenId,
            description: "Take objects from piles — but whoever takes the last object loses (or wins, depending on your variant). A deceptively deep strategy game.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up piles", description: "Create 3–4 piles of objects (coins, matches, drawn marks on paper). A classic setup: piles of 3, 5, and 7 objects."),
                GameStep(stepNumber: 2, title: "Take from one pile", description: "On your turn, take any number of objects from exactly one pile. You must take at least one."),
                GameStep(stepNumber: 3, title: "Force your opponent", description: "Manipulate the piles to put your opponent in a losing position. The math behind NIM is real — learn the strategy to dominate."),
                GameStep(stepNumber: 4, title: "Last object", description: "The player forced to take the last remaining object loses (Misère NIM). In standard NIM, taking the last object wins."),
                GameStep(stepNumber: 5, title: "Agree on variant", description: "Decide before starting: does taking the last object win or lose? Both versions are valid."),
            ],
            whatYouNeed: ["Paper and pen (to draw marks as piles) or coins/matches"],
            minPlayers: 2, maxPlayers: 2,
            duration: "5–15 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "a0000006-0000-0000-0000-000000000000")!,
            name: "SOS",
            categoryId: paperPenId,
            description: "Take turns writing S or O in a grid. Form the sequence S-O-S in a line (any direction) to score a point. Most SOS sequences wins.",
            steps: [
                GameStep(stepNumber: 1, title: "Draw the grid", description: "Draw a grid — 6×6 or 8×8 works well. All cells start empty."),
                GameStep(stepNumber: 2, title: "Write S or O", description: "On your turn, write either an S or an O in any empty cell. Your choice of letter is key."),
                GameStep(stepNumber: 3, title: "Complete an SOS", description: "If your letter completes the sequence S-O-S in a straight line (horizontal, vertical, or diagonal), draw a line through it and score 1 point. You go again immediately."),
                GameStep(stepNumber: 4, title: "Multiple SOS in one move", description: "If one letter completes multiple SOS sequences, you score for each one."),
                GameStep(stepNumber: 5, title: "Win", description: "Play until the grid is full. Player with the most SOS sequences wins."),
            ],
            whatYouNeed: ["Paper", "Pen"],
            minPlayers: 2, maxPlayers: 4,
            duration: "10–20 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "a0000007-0000-0000-0000-000000000000")!,
            name: "Fishbowl",
            categoryId: paperPenId,
            description: "One bowl, three rounds. The same clues get harder to describe each round: first Taboo-style, then Charades, then just one word. Teams race to guess the most.",
            steps: [
                GameStep(stepNumber: 1, title: "Write clues", description: "Everyone writes 3 words or phrases on separate slips of paper and puts them in a bowl. Anything goes — inside jokes, famous names, objects, phrases."),
                GameStep(stepNumber: 2, title: "Round 1 — Taboo", description: "Split into 2 teams. One player draws slips and describes each word without saying it. Their team guesses. 60 seconds per turn. Rotate until the bowl is empty, then count points and refill the bowl."),
                GameStep(stepNumber: 3, title: "Round 2 — Charades", description: "Same slips, same teams. This time the describer can only use gestures — no words, no sounds. Team guesses from the action. 60 seconds per turn."),
                GameStep(stepNumber: 4, title: "Round 3 — One Word", description: "Same slips again. The describer may say exactly one word as a clue. The team must guess the full phrase from that single word. 60 seconds per turn."),
                GameStep(stepNumber: 5, title: "Score", description: "Each correctly guessed clue = 1 point per round. Total across all 3 rounds. Team with the most points wins."),
            ],
            whatYouNeed: ["Paper", "Pens", "A bowl or hat", "Timer"],
            minPlayers: 4, maxPlayers: 99,
            duration: "30–60 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        // ── WORD GAMES (additions) ─────────────────────────────

        Game(
            id: UUID(uuidString: "40000004-0000-0000-0000-000000000000")!,
            name: "Wavelength",
            categoryId: wordGamesId,
            description: "One player closes their eyes while the group picks a number. Then they open their eyes and give each person a category — the answers should help them guess the number.",
            steps: [
                GameStep(stepNumber: 1, title: "Close your eyes", description: "One player (the guesser) closes their eyes. The rest of the group secretly picks a number from 1 to 100 (or any agreed range)."),
                GameStep(stepNumber: 2, title: "Open your eyes and assign categories", description: "The guesser opens their eyes. They go around the circle giving each person a category — any category at all (e.g., 'favorite restaurant in NYC,' 'a movie that scared you,' 'something you'd see on a Tuesday')."),
                GameStep(stepNumber: 3, title: "Everyone answers", description: "Each person answers their category with the first thing that comes to mind. The answer should help the guesser figure out the number."),
                GameStep(stepNumber: 4, title: "Guesser makes their guess", description: "After hearing all answers, the guesser makes their number guess based on the vibe of the responses."),
                GameStep(stepNumber: 5, title: "Reveal and discuss", description: "Reveal the actual number. Discuss how each answer pointed toward (or away from) it. Score points based on proximity to the target."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 4, maxPlayers: 12,
            duration: "Open-ended", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "40000005-0000-0000-0000-000000000000")!,
            name: "Psychiatrist",
            categoryId: wordGamesId,
            description: "One person steps out of the room. The remaining group adopts a secret shared rule. The outsider comes back and asks yes/no questions to figure out the rule.",
            steps: [
                GameStep(stepNumber: 1, title: "Pick the psychiatrist", description: "One player (the psychiatrist) leaves the room or covers their ears."),
                GameStep(stepNumber: 2, title: "Make a rule", description: "The remaining players secretly agree on a rule that changes how they answer. Examples: 'We answer as if we are the person to our left,' 'We lie if we're wearing shoes,' 'We only speak in questions.'"),
                GameStep(stepNumber: 3, title: "The psychiatrist returns", description: "The psychiatrist comes back and begins interviewing players with any questions they like to figure out the secret rule."),
                GameStep(stepNumber: 4, title: "Answer according to the rule", description: "All players answer honestly within the constraints of the rule. Don't give it away too easily."),
                GameStep(stepNumber: 5, title: "Guess the rule", description: "The psychiatrist can guess the rule at any time. If correct, the round ends and a new psychiatrist is chosen. If wrong, questioning continues."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 4, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "40000006-0000-0000-0000-000000000000")!,
            name: "Essence",
            categoryId: wordGamesId,
            description: "Think of one person in the group secretly. Everyone asks you 'essence' questions — if this person were a color, a season, a type of food — and tries to guess who you're thinking of.",
            steps: [
                GameStep(stepNumber: 1, title: "Pick a person", description: "One player secretly thinks of someone in the group. Don't reveal who."),
                GameStep(stepNumber: 2, title: "Ask essence questions", description: "Other players take turns asking questions about the person's 'essence.' Examples: 'If this person were a type of weather, what would they be?' 'A meal?' 'A time of day?' 'A sound?'"),
                GameStep(stepNumber: 3, title: "Answer honestly", description: "Answer each question based on how you truly feel the chosen person embodies that thing. Don't be too literal or too abstract."),
                GameStep(stepNumber: 4, title: "Ask 6 questions", description: "After 6 questions have been asked, the group makes their guesses simultaneously."),
                GameStep(stepNumber: 5, title: "Reveal and discuss", description: "Reveal who you were thinking of. Discuss which answers gave it away and which were surprising."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 4, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "40000008-0000-0000-0000-000000000000")!,
            name: "Contact",
            categoryId: wordGamesId,
            description: "One person thinks of a word. Others try to 'make contact' by thinking of the same word as each other from a clue — without the word-holder guessing it first.",
            steps: [
                GameStep(stepNumber: 1, title: "Word holder picks a word", description: "One player (the word holder) thinks of a word and reveals only the first letter."),
                GameStep(stepNumber: 2, title: "Give a clue", description: "Another player gives a vague clue for a word starting with that letter — one the word holder may not guess. Example: for 'C' — 'It's a vegetable.'"),
                GameStep(stepNumber: 3, title: "Word holder guesses", description: "The word holder tries to guess what word the clue refers to. If they guess correctly before anyone says 'Contact,' the round continues."),
                GameStep(stepNumber: 4, title: "Make contact", description: "If two other players both think they know the clue word, they count down '3-2-1 Contact' and say their answer simultaneously. If they match, the word holder must reveal the next letter."),
                GameStep(stepNumber: 5, title: "Reveal letters until guessed", description: "Keep revealing letters until someone guesses the full word or the word holder concedes."),
                GameStep(stepNumber: 6, title: "Win", description: "The player who correctly guesses the full word becomes the new word holder."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 3, maxPlayers: 99,
            duration: "Open-ended", difficulty: "Medium",
            isLibraryGame: true
        ),

        // ── RIDDLES (additions) ────────────────────────────────

        Game(
            id: UUID(uuidString: "30000003-0000-0000-0000-000000000000")!,
            name: "How Many Horses",
            categoryId: riddlesId,
            description: "Knock on the table some number of times, then ask 'How many horses are there?' The trick: the answer has nothing to do with knocking — it's the number of words in your question.",
            steps: [
                GameStep(stepNumber: 1, title: "Set up the riddle", description: "One player (who knows the secret) knocks on the table some number of times — it doesn't matter how many."),
                GameStep(stepNumber: 2, title: "Ask the question", description: "After knocking, ask 'How many horses are there?' (4 words in the question → answer is 4) or vary the phrasing."),
                GameStep(stepNumber: 3, title: "Players guess a number", description: "Other players try to guess the answer. They'll likely count the knocks — that's the misdirection."),
                GameStep(stepNumber: 4, title: "Reveal and replay", description: "Reveal whether they're right or wrong. Play again with a different number of words in your question."),
                GameStep(stepNumber: 5, title: "The secret", description: "The answer is always the number of words in your spoken question. The knocking is completely irrelevant. Once players know, they can host their own rounds."),
            ],
            whatYouNeed: ["Nothing — just a surface to knock on"],
            minPlayers: 2, maxPlayers: 99,
            duration: "5–10 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "30000004-0000-0000-0000-000000000000")!,
            name: "Green Glass Door",
            categoryId: riddlesId,
            description: "Some things can go through the green glass door — some can't. The pattern is hidden. Say 'a puppy can go through, but not a dog' and watch people lose their minds.",
            steps: [
                GameStep(stepNumber: 1, title: "Introduce the door", description: "Tell players: 'There is a green glass door. Some things can go through it — some things can't. Figure out the rule.'"),
                GameStep(stepNumber: 2, title: "Give examples", description: "Start with clear examples: 'A kitten can go through, but a cat cannot. A coffee can go through, but tea cannot. A grass lawn can go through, but a park cannot.'"),
                GameStep(stepNumber: 3, title: "Players guess items", description: "Players take turns naming things and asking if they can go through. You confirm or deny without explaining."),
                GameStep(stepNumber: 4, title: "The rule", description: "Only words with double letters can go through the green glass door: kiitten (wait — kitten has no doubles), actually: words with repeated consecutive letters like 'coffee' (ff), 'grass' (ss), 'puppy' (pp). No double letters = can't go through."),
                GameStep(stepNumber: 5, title: "Variations", description: "Once someone figures it out, let them host the next round with a different pattern they invent — e.g., only things with silent letters, only palindromes, etc."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 2, maxPlayers: 99,
            duration: "5–15 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "30000005-0000-0000-0000-000000000000")!,
            name: "Black Magic",
            categoryId: riddlesId,
            description: "Two players are in on it. One leaves the room, the group picks an object. When the insider asks questions, they signal the answer by mentioning a black object first.",
            steps: [
                GameStep(stepNumber: 1, title: "Two people know the secret", description: "Two players know how the trick works. One (the guesser) leaves the room. The group picks any object in the room."),
                GameStep(stepNumber: 2, title: "The guesser returns", description: "The insider starts asking 'Is it [object]?' pointing to random objects. The guesser says 'No' each time."),
                GameStep(stepNumber: 3, title: "The signal", description: "Before pointing to the correct object, the insider points to any black-colored object. This is the secret signal."),
                GameStep(stepNumber: 4, title: "The next object is the answer", description: "The guesser knows: the object immediately after the black one is the correct answer. They say 'Yes!'"),
                GameStep(stepNumber: 5, title: "The audience reacts", description: "The group is baffled. Let them try to guess how it works. Accept variations — white objects, even numbers of questions, etc."),
            ],
            whatYouNeed: ["Nothing — just a room with objects"],
            minPlayers: 2, maxPlayers: 99,
            duration: "5–10 min", difficulty: "Medium",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "30000006-0000-0000-0000-000000000000")!,
            name: "4 is the Magic Number",
            categoryId: riddlesId,
            description: "Any number you say will always converge to 4 — because 4 is the only number where the letter count equals the number itself. Watch people try to break it.",
            steps: [
                GameStep(stepNumber: 1, title: "Ask for a number", description: "Ask someone to give you any number."),
                GameStep(stepNumber: 2, title: "Count the letters", description: "Say that number's name and count its letters, then say the next number's name and count those letters, chaining until you reach 4."),
                GameStep(stepNumber: 3, title: "Demo", description: "Example: 'Ten is 3. Three is 5. Five is 4. Four is 4. Four is always 4.' Try: 'One hundred is 10. Ten is 3. Three is 5. Five is 4.'"),
                GameStep(stepNumber: 4, title: "The rule", description: "4 is the only number in English where the count of letters exactly equals the number itself: F-O-U-R = 4 letters = 4. Every chain converges to 4."),
                GameStep(stepNumber: 5, title: "Let them try to escape", description: "Let players pick giant numbers, negative numbers, or fractions. It always comes back to 4. Have them figure out why."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 2, maxPlayers: 99,
            duration: "5–10 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "30000007-0000-0000-0000-000000000000")!,
            name: "Good Line / Bad Line",
            categoryId: riddlesId,
            description: "Draw random lines in the air and declare them good or bad. Players try to figure out the pattern. The trick: anything with 'um' before it is a bad line.",
            steps: [
                GameStep(stepNumber: 1, title: "Introduce the game", description: "Tell players you'll draw lines in the air and declare each one good or bad. They have to figure out the rule."),
                GameStep(stepNumber: 2, title: "Draw and label", description: "Draw any shape or line and say 'This is a good line' or 'Um, this is a bad line.' Vary the lines wildly — long, short, squiggly, straight."),
                GameStep(stepNumber: 3, title: "The secret", description: "If you say 'um' (or any filler word) before your declaration, it's a bad line. If you don't, it's a good line. The actual drawing is irrelevant."),
                GameStep(stepNumber: 4, title: "Players guess", description: "Let players study your lines and guess the rule. They'll obsess over the shapes. Let them guess — confirm only if correct."),
                GameStep(stepNumber: 5, title: "Once discovered", description: "Anyone who figures it out can secretly join you in drawing lines, helping confuse others. Keep it going until everyone knows."),
            ],
            whatYouNeed: ["Nothing — just people"],
            minPlayers: 2, maxPlayers: 99,
            duration: "5–10 min", difficulty: "Easy",
            isLibraryGame: true
        ),

        Game(
            id: UUID(uuidString: "30000008-0000-0000-0000-000000000000")!,
            name: "Is It Open or Closed",
            categoryId: riddlesId,
            description: "Show an object that can be opened or closed. The trick isn't about the object — it's about whether your mouth is open or closed when you ask the question.",
            steps: [
                GameStep(stepNumber: 1, title: "Pick an object", description: "Hold any object that can be open or closed — a water bottle, a clip, a book, a jar. Open and close it a few times to set expectations."),
                GameStep(stepNumber: 2, title: "Set the position and ask", description: "Hold the object in some position (open or closed — doesn't matter) and ask: 'Is it open or closed?'"),
                GameStep(stepNumber: 3, title: "The secret", description: "The answer depends entirely on whether your mouth is open or closed when you ask the question — not the object. If your mouth is open, the answer is open. If it's closed, the answer is closed."),
                GameStep(stepNumber: 4, title: "Confirm answers", description: "Players guess based on the object position. Confirm right or wrong without explaining. Let them notice the pattern."),
                GameStep(stepNumber: 5, title: "Let them try", description: "Once someone guesses it, let them run the trick on someone else in the group."),
            ],
            whatYouNeed: ["Any object that can be opened or closed (bottle, clip, book, etc.)"],
            minPlayers: 2, maxPlayers: 99,
            duration: "5–10 min", difficulty: "Easy",
            isLibraryGame: true
        ),
    ]
}
