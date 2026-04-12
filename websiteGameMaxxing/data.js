// GameMaxxing Web — Full Game Library
// Converted from iOS GameLibrary.swift

const CATEGORIES = [
  { id: "cat-cards",    name: "Card Games",     emoji: "🃏" },
  { id: "cat-mind",     name: "Mind Games",     emoji: "🧠" },
  { id: "cat-riddles",  name: "Riddles",        emoji: "🎭" },
  { id: "cat-word",     name: "Word Games",     emoji: "🗣️" },
  { id: "cat-dice",     name: "Dice Games",     emoji: "🎲" },
  { id: "cat-drinking", name: "Drinking Games", emoji: "🍻" },
  { id: "cat-party",    name: "Party Games",    emoji: "🎉" },
  { id: "cat-app",      name: "App Games",      emoji: "📱" },
  { id: "cat-car",      name: "Car Games",      emoji: "🚗" },
  { id: "cat-paper",    name: "Paper & Pen",    emoji: "✏️" },
];

const LIBRARY_GAMES = [

  // ── CARD GAMES ─────────────────────────────────────────────────────────

  {
    id: "10000001", name: "Uno Attack", categoryId: "cat-cards",
    description: "A chaotic twist on classic Uno. Instead of drawing from a pile, you press a motorized launcher that may or may not blast a pile of cards at you. Expect chaos.",
    steps: [
      { num: 1, title: "Load & deal", desc: "Shuffle all cards into the launcher. Deal 7 cards to each player face down." },
      { num: 2, title: "Flip a starter card", desc: "Press the launcher once to reveal the first discard card and place it face-up." },
      { num: 3, title: "Match and play", desc: "On your turn play a card that matches the top discard by color or number." },
      { num: 4, title: "Can't play? Press the launcher", desc: "If you have no match, press the launcher button. It may fire zero cards — or a handful. Take whatever comes out." },
      { num: 5, title: "Use action cards", desc: "Skip, Reverse, Draw Two, and Wild cards change the game. Hit cards send the next player to the launcher." },
      { num: 6, title: "Shout UNO!", desc: "When you have one card left shout 'UNO!' before the next player takes their turn or you must press the launcher." },
      { num: 7, title: "Win", desc: "First to empty their hand wins. Score remaining cards in opponents' hands. First to 500 wins the match." },
    ],
    whatYouNeed: ["Uno Attack deck & card launcher", "2× AA batteries", "Table or flat surface"],
    minPlayers: 2, maxPlayers: 10, duration: "15–30 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000002", name: "Spoons", categoryId: "cat-cards",
    description: "Collect four of a kind and grab a spoon before everyone else. If you're the one left without a spoon, you're out. Gets physical and chaotic fast.",
    steps: [
      { num: 1, title: "Set up the spoons", desc: "Place one fewer spoon than the number of players in the center of the table. Everyone can reach them." },
      { num: 2, title: "Deal 4 cards each", desc: "Deal 4 cards to each player. Place the remaining deck beside the dealer." },
      { num: 3, title: "Pass left simultaneously", desc: "The dealer picks a card from the deck, keeps it or swaps it into their hand, then passes one card face-down to the left. Everyone passes at the same time." },
      { num: 4, title: "Collect four of a kind", desc: "The moment you have four matching cards, quietly take a spoon from the center." },
      { num: 5, title: "Grab a spoon", desc: "Once anyone takes a spoon, everyone else must grab one immediately — even if they don't have four of a kind." },
      { num: 6, title: "Eliminate", desc: "The player left without a spoon gets a letter: S, then P, then O, then N, then S. Spell SPOONS and you're out." },
    ],
    whatYouNeed: ["Standard 52-card deck", "Spoons (one fewer than player count)"],
    minPlayers: 3, maxPlayers: 8, duration: "10–20 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000003", name: "Egyptian Rat Screw", categoryId: "cat-cards",
    description: "Slap the pile at exactly the right moment to steal the whole stack. Fastest reflexes win. Sandwiches, doubles, and runs trigger the slap.",
    steps: [
      { num: 1, title: "Deal all cards", desc: "Deal the full deck evenly to all players. Cards are kept face-down in a personal pile." },
      { num: 2, title: "Flip and stack", desc: "In turn, each player flips the top card of their pile onto a central pile. Do not look at the card before flipping." },
      { num: 3, title: "Slap on doubles", desc: "If two cards of the same value appear consecutively, slap the pile. First hand on the pile takes all cards." },
      { num: 4, title: "Slap on sandwiches", desc: "If the same value appears with any one card between them (e.g. 5–9–5), slap the pile." },
      { num: 5, title: "Face card challenge", desc: "When a face card (J, Q, K, A) is played, the next player must play a face card within 1–4 chances or the challenger takes the pile." },
      { num: 6, title: "Win", desc: "Collect all 52 cards to win. If you run out of cards you can still slap back in." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 2, maxPlayers: 6, duration: "20–40 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000004", name: "Presidents", categoryId: "cat-cards",
    description: "Play your cards to climb the social ladder. Be the President, avoid being the Scum. Roles flip each round based on who finishes first.",
    steps: [
      { num: 1, title: "Deal all cards", desc: "Deal the entire deck evenly to all players. Players sort their hands." },
      { num: 2, title: "First round: 3 of Clubs starts", desc: "The player holding the 3 of Clubs plays first. They can play any set of cards including that 3." },
      { num: 3, title: "Beat or pass", desc: "Each player must play a higher card or set of the same count as the last play, or pass. 2s are highest. Suits don't matter." },
      { num: 4, title: "Clear the pile", desc: "When everyone passes, the last player to play clears the pile and starts fresh." },
      { num: 5, title: "Finish and rank", desc: "First to empty their hand is President. Second is Vice President. Last two are Vice Scum and Scum." },
      { num: 6, title: "Trade cards", desc: "Next round: Scum gives their two best cards to President. President gives any two back. Vice positions trade one card." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 4, maxPlayers: 7, duration: "30–60 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000005", name: "Crazy Eights", categoryId: "cat-cards",
    description: "Get rid of all your cards by matching the suit or number on the discard pile. Eights are wild and let you name the next suit.",
    steps: [
      { num: 1, title: "Deal 5 cards each", desc: "Deal 5 cards to each player (7 in a 2-player game). Place the rest face-down as the draw pile and flip the top card." },
      { num: 2, title: "Match suit or number", desc: "Play a card matching the discard's suit or number. You can play as many matching cards as you like in one turn." },
      { num: 3, title: "Play an Eight", desc: "Eights are wild — play one any time and call the next suit." },
      { num: 4, title: "Draw if you can't play", desc: "If you can't play, draw from the pile until you can or until the pile runs out." },
      { num: 5, title: "Win", desc: "First player to empty their hand wins the round. Score the cards left in opponents' hands (face cards = 10, Aces = 1, Eights = 50)." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 2, maxPlayers: 8, duration: "15–25 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000006", name: "Go Fish", categoryId: "cat-cards",
    description: "Ask opponents for cards to complete sets of four. If they don't have it, they say 'Go Fish' and you draw from the pond.",
    steps: [
      { num: 1, title: "Deal 5–7 cards", desc: "Deal 7 cards each for 2–3 players, or 5 cards each for 4 or more. Remaining cards form the draw pile (the pond)." },
      { num: 2, title: "Ask for a card", desc: "On your turn, ask any player: 'Do you have any [value]?' You must already hold at least one of that value." },
      { num: 3, title: "Transfer or Go Fish", desc: "If they have the card, they hand it over and you ask again. If not, they say 'Go Fish' — draw one card from the pond." },
      { num: 4, title: "Lay down sets of four", desc: "When you collect all four cards of a value, place the set face-up in front of you." },
      { num: 5, title: "Win", desc: "When all cards have been formed into sets, the player with the most sets wins." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 2, maxPlayers: 6, duration: "10–15 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000007", name: "Speed", categoryId: "cat-cards",
    description: "A lightning-fast 2-player race to get rid of all your cards. No turns — both players play simultaneously until someone runs out.",
    steps: [
      { num: 1, title: "Set up the layout", desc: "Deal 20 cards to each player. Place 5 in each player's side pile, then deal 1 card face-down to each of the 2 center slots. Each player also gets a 5-card hand from their remaining pile." },
      { num: 2, title: "Flip and go", desc: "Both players flip the two center cards simultaneously. There are no turns — play as fast as you can." },
      { num: 3, title: "Play on center piles", desc: "Play a card from your hand onto either center pile if it's one higher or one lower than the top card. Suit doesn't matter. Aces can be high or low." },
      { num: 4, title: "Refill your hand", desc: "Keep 5 cards in your hand at all times by drawing from your side pile whenever possible." },
      { num: 5, title: "Slap in if stuck", desc: "If neither player can play, both slap a side pile card onto the center simultaneously to restart." },
      { num: 6, title: "Win", desc: "First player to play all their cards — hand and side pile — wins." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 2, maxPlayers: 2, duration: "5–10 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000008", name: "Trash", categoryId: "cat-cards",
    description: "Fill your 10-card layout in order from Ace to 10. Draw cards and place them in the right spot — or pass them along if they don't fit.",
    steps: [
      { num: 1, title: "Deal 10 cards face-down", desc: "Deal 10 cards face-down to each player in two rows of 5. Number the positions 1–10 in your head (Ace through 10)." },
      { num: 2, title: "Draw and place", desc: "Draw a card from the deck. If it's an Ace through 10, place it face-up in the matching position and flip the card that was there." },
      { num: 3, title: "Chain flips", desc: "The flipped card goes to its corresponding position, displacing the next card — chain as long as you can." },
      { num: 4, title: "Jacks, Queens, Kings", desc: "Jacks and Queens are trash — discard them and your turn ends. Kings are wild and go anywhere." },
      { num: 5, title: "Complete your layout", desc: "When all 10 positions are filled face-up, you win the round. Next round you only need 9 positions, then 8, and so on." },
      { num: 6, title: "Win", desc: "First player to complete a 1-card layout (just an Ace) wins the game." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 2, maxPlayers: 4, duration: "15–25 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000009", name: "War", categoryId: "cat-cards",
    description: "Flip the top card of your deck and whoever plays higher wins both cards. Simple as it gets — but it can go on forever.",
    steps: [
      { num: 1, title: "Split the deck", desc: "Deal the entire deck face-down, 26 cards each. Players hold their pile face-down." },
      { num: 2, title: "Flip and battle", desc: "Both players flip their top card simultaneously. Higher card wins both and goes to the bottom of the winner's pile. Ace is highest." },
      { num: 3, title: "Declare war on a tie", desc: "If both cards are equal, each player places 3 cards face-down and 1 face-up. The higher face-up card takes all 8 cards." },
      { num: 4, title: "Keep going", desc: "Continue flipping until one player has all 52 cards." },
      { num: 5, title: "Win", desc: "The player who collects all 52 cards wins. (Feel free to play for a set number of rounds instead.)" },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 2, maxPlayers: 2, duration: "20–40 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000010", name: "Rummy", categoryId: "cat-cards",
    description: "Draw and discard to build sets (three of a kind) and runs (three in sequence, same suit). First to meld all their cards wins.",
    steps: [
      { num: 1, title: "Deal 7 cards", desc: "Deal 7 cards to each player (10 for 2 players). Place the remaining deck face-down and flip the top card to start the discard pile." },
      { num: 2, title: "Draw", desc: "On your turn, draw either the top card from the deck or the top card from the discard pile." },
      { num: 3, title: "Meld if you can", desc: "Lay down any sets (3+ cards of the same value) or runs (3+ consecutive cards of the same suit) face-up on the table." },
      { num: 4, title: "Lay off on melds", desc: "You can add cards to existing melds on the table — your own or other players'." },
      { num: 5, title: "Discard", desc: "End your turn by discarding one card face-up onto the discard pile." },
      { num: 6, title: "Win", desc: "First player to meld or lay off all their cards wins. Score remaining cards in opponents' hands (face cards = 10, Aces = 1 or 11)." },
    ],
    whatYouNeed: ["Standard 52-card deck", "Pen and paper for scoring"],
    minPlayers: 2, maxPlayers: 6, duration: "30–60 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000011", name: "Idiot", categoryId: "cat-cards",
    description: "Also known as Palace or Shithead. Work through your hand, then your face-up cards, then flip your blind face-down cards. Last one with cards is the Idiot.",
    steps: [
      { num: 1, title: "Set up your layout", desc: "Deal 3 face-down cards to each player — these are untouchable until the end. Then deal 3 face-up cards on top of them. Finally deal a 3-card hand to each player." },
      { num: 2, title: "Swap before starting", desc: "Before play begins, players may swap any hand cards with their face-up cards to set themselves up." },
      { num: 3, title: "Play from your hand first", desc: "Play a card equal to or higher than the top of the central discard pile. 2s reset the pile (play on anything). 10s burn the pile." },
      { num: 4, title: "Refill your hand", desc: "Always refill your hand to 3 cards from the deck while cards remain. When the deck is gone, play out your hand." },
      { num: 5, title: "Move to face-up, then face-down", desc: "Once your hand is empty, play from your face-up cards. When those are gone, flip face-down cards one at a time and hope for the best." },
      { num: 6, title: "Take the pile if you can't beat it", desc: "If you can't play (or flip a face-down card that's too low), take the entire discard pile into your hand." },
      { num: 7, title: "Lose", desc: "Last player with cards in any form is the Idiot." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 2, maxPlayers: 6, duration: "20–40 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000012", name: "Tunk", categoryId: "cat-cards",
    description: "A quick knock-rummy variant. Build melds to lower your hand value, then tunk when you think you have the lowest. Get caught with a high hand and you're penalized.",
    steps: [
      { num: 1, title: "Deal 5 cards", desc: "Deal 5 cards to each player. Flip the top remaining card to start the discard pile." },
      { num: 2, title: "Draw and discard", desc: "On your turn, draw from the deck or discard pile, then discard one card. Form sets (same value) or runs (consecutive same suit) to reduce your deadwood." },
      { num: 3, title: "Tunk to end the round", desc: "When you believe your unmelded card total is the lowest at the table, say 'Tunk' and lay down your hand." },
      { num: 4, title: "Everyone else reveals", desc: "All other players reveal and total their unmelded cards." },
      { num: 5, title: "Score", desc: "If the tunker has the lowest count, others score their deadwood. If someone ties or beats the tunker, the tunker is penalized double. Face cards = 10, Aces = 1." },
      { num: 6, title: "Win", desc: "Play to a target score (e.g. 100). Lowest cumulative score wins." },
    ],
    whatYouNeed: ["Standard 52-card deck", "Pen and paper for scoring"],
    minPlayers: 2, maxPlayers: 6, duration: "20–40 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000013", name: "Literature", categoryId: "cat-cards",
    description: "A team-based set collection game. Ask teammates and opponents for cards to complete half-suits. Only your team can claim a half-suit you think you hold.",
    steps: [
      { num: 1, title: "Set up teams and deck", desc: "Split into 2 teams of 3 (or 4). Remove the 8s from the deck. The remaining cards form 8 half-suits (low: A–7 per suit, high: 9–K per suit). Deal all cards evenly." },
      { num: 2, title: "Ask for cards", desc: "On your turn, ask any opponent for a specific card (e.g. 'Jack, do you have the 3 of Hearts?'). You must already hold a card from that half-suit." },
      { num: 3, title: "Transfer or lose your turn", desc: "If they have it, they hand it over and you ask again. If not, your turn ends and that player goes next." },
      { num: 4, title: "Ask teammates", desc: "You can also ask teammates for cards — useful for consolidating a half-suit onto one player." },
      { num: 5, title: "Declare a half-suit", desc: "When your team believes it holds all 6 cards of a half-suit, any team member declares it by naming where each card is. If correct, your team scores the set." },
      { num: 6, title: "Win", desc: "The team that claims the most half-suits wins." },
    ],
    whatYouNeed: ["Standard 52-card deck (remove the 8s)"],
    minPlayers: 6, maxPlayers: 12, duration: "30–60 min", difficulty: "Hard",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000014", name: "Coup", categoryId: "cat-cards",
    description: "Bluff your way to power. Each player has 2 hidden role cards. Take actions as if you hold any role — but if someone calls your bluff and wins, you lose an influence.",
    steps: [
      { num: 1, title: "Deal 2 role cards", desc: "Shuffle the Coup deck (Duke, Assassin, Captain, Ambassador, Contessa — 3 copies each). Deal 2 face-down to each player. Give everyone 2 coins." },
      { num: 2, title: "Take an action", desc: "On your turn, take one action: Income (1 coin), Foreign Aid (2 coins, Duke can block), Coup (pay 7 coins, eliminate an influence), or a character action." },
      { num: 3, title: "Character actions", desc: "Duke: Tax (3 coins). Assassin: Assassinate (pay 3 coins, target loses influence — Contessa blocks). Captain: Steal 2 coins from a player (Ambassador or Captain blocks). Ambassador: Exchange your cards." },
      { num: 4, title: "Challenge a bluff", desc: "Any player can challenge any action or block. The challenged player reveals their role — if guilty, they lose an influence; if innocent, the challenger loses one." },
      { num: 5, title: "Lose influence", desc: "When you lose an influence, reveal and discard one role card. Lose both and you're eliminated." },
      { num: 6, title: "Win", desc: "Last player with at least one influence card wins." },
    ],
    whatYouNeed: ["Coup card game", "Coins or chips for tracking"],
    minPlayers: 2, maxPlayers: 6, duration: "15–30 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000015", name: "Golf", categoryId: "cat-cards",
    description: "Arrange a 6-card grid and aim for the lowest score. Swap cards strategically over several rounds. Lowest cumulative score after 9 rounds wins.",
    steps: [
      { num: 1, title: "Deal a 6-card grid", desc: "Deal 6 cards face-down to each player in a 2×3 grid. Flip any 2 cards of your choice face-up to start." },
      { num: 2, title: "Draw and swap", desc: "On your turn, draw from the deck or discard pile. Swap it with any card in your grid (flip the new card face-up) and discard the replaced card." },
      { num: 3, title: "Card values", desc: "2s = −2, Aces = 1, face cards = 10, Jokers = 0. Matching pairs in the same column cancel out (score 0 for that column)." },
      { num: 4, title: "Knock to end the round", desc: "When you think you have the lowest score, knock. All other players get one more turn, then everyone reveals their full grid." },
      { num: 5, title: "Penalty for bad knock", desc: "If the knocker doesn't have the lowest score, their total is doubled for that round." },
      { num: 6, title: "Win", desc: "Play 9 rounds (holes). Lowest cumulative score wins. Add a penalty stroke to any unflipped card left at the end of a round." },
    ],
    whatYouNeed: ["Standard 52-card deck (add Jokers)", "Pen and paper for scoring"],
    minPlayers: 2, maxPlayers: 8, duration: "20–40 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000016", name: "Red King", categoryId: "cat-cards",
    description: "A trick-taking game where the Red Kings are secretly powerful. Avoid taking certain cards or tricks — whoever ends up with the Red Kings pays the price.",
    steps: [
      { num: 1, title: "Deal all cards", desc: "Deal the entire deck evenly. Players sort their hands. No trump suit." },
      { num: 2, title: "Lead a card", desc: "The player to the dealer's left leads any card. Others must follow suit if they can; otherwise they may play anything." },
      { num: 3, title: "Win the trick", desc: "Highest card of the leading suit wins the trick. The winner leads the next trick." },
      { num: 4, title: "Track the Red Kings", desc: "At the end of the round, check who captured tricks containing the King of Hearts and King of Diamonds. These score penalty points." },
      { num: 5, title: "Score", desc: "Each Red King captured = 10 penalty points. Other scoring cards can be agreed on before the game (e.g. Queen of Spades)." },
      { num: 6, title: "Win", desc: "After a set number of rounds, the player with the fewest penalty points wins." },
    ],
    whatYouNeed: ["Standard 52-card deck", "Pen and paper for scoring"],
    minPlayers: 3, maxPlayers: 8, duration: "15–30 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000017", name: "Fuck Thy Neighbor", categoryId: "cat-cards",
    description: "Also known as Chase the Ace. Everyone gets one card — try not to end up with the lowest. Pass your card to your neighbor before it's too late.",
    steps: [
      { num: 1, title: "Deal one card each", desc: "Deal one card face-down to each player. Everyone secretly looks at their card without showing others." },
      { num: 2, title: "Decide to keep or swap", desc: "Starting left of the dealer, each player decides to keep their card or swap it with the neighbor to their left. The neighbor must swap unless they have a King (Kings block all swaps)." },
      { num: 3, title: "Dealer draws", desc: "The dealer is last. They can keep their card or swap it for a random card from the top of the deck." },
      { num: 4, title: "Reveal", desc: "Everyone reveals their card simultaneously. Aces are lowest, Kings are highest." },
      { num: 5, title: "Lose a life", desc: "The player with the lowest card loses a life (start with 3). Ties all lose a life." },
      { num: 6, title: "Win", desc: "Last player with lives remaining wins." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 3, maxPlayers: 10, duration: "10–20 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000018", name: "Cambio", categoryId: "cat-cards",
    description: "You have 4 cards and can only peek at 2 of them. Draw and swap strategically to minimize your total. Call 'Cambio' when you think you're lowest — but if you're wrong, you score extra.",
    steps: [
      { num: 1, title: "Deal 4 cards", desc: "Deal 4 cards face-down to each player in a row. Players may look at the 2 cards closest to them only — memorize them, then place them face-down." },
      { num: 2, title: "Draw and decide", desc: "On your turn, draw from the deck. You can swap it with any of your 4 cards (even ones you haven't seen) or discard it." },
      { num: 3, title: "Special card powers", desc: "Some cards have powers when discarded: 7/8 = peek at one of your own cards; 9/10 = peek at an opponent's card; J/Q = swap one of your cards with an opponent's blindly; K = no effect." },
      { num: 4, title: "Call Cambio", desc: "Instead of drawing, any player can call 'Cambio.' All other players get one final turn, then everyone reveals." },
      { num: 5, title: "Score", desc: "Total all card values (Ace=1, 2–10 face value, J/Q=10, K=0). The player who called Cambio gets double points if they don't have the lowest total." },
      { num: 6, title: "Win", desc: "Play to a target score (e.g. 100). Lowest cumulative score wins." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 2, maxPlayers: 8, duration: "15–30 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000019", name: "31", categoryId: "cat-cards",
    description: "Hold 3 cards and aim for the highest sum in a single suit. Go around the circle swapping cards until someone knocks. Lowest hand drinks or loses a life.",
    steps: [
      { num: 1, title: "Deal 3 cards each", desc: "Deal 3 cards to each player. Flip one card to start the discard pile. Each player also gets chips or coins to track lives (start with 3)." },
      { num: 2, title: "Goal: same suit, high sum", desc: "Aim to have 3 cards of the same suit with the highest possible total. Ace = 11, face cards = 10. Three of a kind = 30.5 (beats any suited hand)." },
      { num: 3, title: "Take a turn", desc: "On your turn, draw the top card from the deck or discard pile, keep it, and discard one of your 3 cards." },
      { num: 4, title: "Knock to trigger the final round", desc: "Instead of drawing, you can knock. Everyone else gets exactly one more turn, then all hands are revealed." },
      { num: 5, title: "Blitz", desc: "If you have exactly 31 (Ace + two 10-value cards of the same suit), reveal immediately — everyone else loses a life." },
      { num: 6, title: "Lose a life", desc: "Player with the lowest hand loses a life (or takes a drink). Knock at the right time — the knocker also loses a life if they don't have the lowest hand." },
    ],
    whatYouNeed: ["Standard 52-card deck", "Chips or coins for lives"],
    minPlayers: 2, maxPlayers: 9, duration: "15–30 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000020", name: "Scum", categoryId: "cat-cards",
    description: "Play your cards to finish first and claim the throne. The social hierarchy flips every round — President, Vice President, Vice Scum, and Scum trade cards before each game.",
    steps: [
      { num: 1, title: "Deal all cards", desc: "Deal the entire deck evenly to all players. Players sort their hands. 2s are highest, 3s are lowest." },
      { num: 2, title: "First round: lowest card starts", desc: "Player with the 3 of Clubs plays first. They play any single card or set of equal-value cards." },
      { num: 3, title: "Beat or pass", desc: "Each player must play a higher set of the same size, or pass. Once everyone passes, the last player to play clears the pile and leads again." },
      { num: 4, title: "Rank up", desc: "First to empty their hand is President. Second is Vice President. Second-to-last is Vice Scum. Last is Scum." },
      { num: 5, title: "Trade cards next round", desc: "Scum gives their 2 best cards to President, who gives back any 2. Vice Scum and Vice President trade 1 card." },
      { num: 6, title: "Win", desc: "Play as many rounds as desired. The player who holds the President title most often is the overall winner." },
    ],
    whatYouNeed: ["Standard 52-card deck"],
    minPlayers: 4, maxPlayers: 8, duration: "30–60 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "10000021", name: "Pyramid", categoryId: "cat-cards",
    description: "A bluffing drinking game built around a pyramid of face-down cards. When a card is flipped, players claim to have a match and assign drinks — but you can always call their bluff.",
    steps: [
      { num: 1, title: "Build the pyramid", desc: "Lay cards face-down in a pyramid: 5 cards on the bottom row, then 4, 3, 2, 1 on top. Deal 4 cards face-down to each player — these are your secret hand." },
      { num: 2, title: "Know your hand", desc: "Look at your cards and memorize them, then place them face-down. You'll claim to have matching cards without showing them." },
      { num: 3, title: "Flip pyramid cards", desc: "The dealer flips cards row by row, starting from the bottom. Row 1 = 1 drink, Row 2 = 2 drinks, etc. up to 5 at the top." },
      { num: 4, title: "Assign drinks on a match", desc: "When a card is flipped, any player who claims to have a matching card in their hand may assign drinks equal to that row's value to any player." },
      { num: 5, title: "Call a bluff", desc: "The assigned player can call a bluff. If the claimer has the matching card, the doubter drinks double. If they were bluffing, the claimer drinks double." },
      { num: 6, title: "Finish the pyramid", desc: "Continue through all 15 cards. After the pyramid is complete, players must drink for any cards remaining in their hand that were never played." },
    ],
    whatYouNeed: ["Standard 52-card deck", "Drinks"],
    minPlayers: 3, maxPlayers: 8, duration: "20–40 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  {
    id: "10000022", name: "Ride the Bus", categoryId: "cat-cards",
    description: "A two-part card drinking game. First, avoid collecting cards in the deal phase. Then the player with the most cards has to ride the bus — a gauntlet of 4 guesses with drinks for each wrong answer.",
    steps: [
      { num: 1, title: "Deal phase: round one", desc: "The dealer asks each player in turn: 'Red or Black?' Flip a card — wrong answer = drink 1. Right answer = no drink." },
      { num: 2, title: "Higher or lower?", desc: "Using their first card, each player guesses: 'Higher or Lower?' for the next flip. Wrong = drink 2." },
      { num: 3, title: "In between or outside?", desc: "Using their two cards, guess if the next card lands between or outside them. Wrong = drink 3." },
      { num: 4, title: "Guess the suit", desc: "Guess the suit of the next flip (1 in 4 chance). Wrong = drink 4." },
      { num: 5, title: "Count cards", desc: "After all players have gone through all 4 questions, the player with the most cards in front of them rides the bus." },
      { num: 6, title: "Ride the bus", desc: "The bus rider repeats the 4 questions from the deck. Each wrong answer = drink that row's value. They keep going until they get all 4 right in a row." },
    ],
    whatYouNeed: ["Standard 52-card deck", "Drinks"],
    minPlayers: 3, maxPlayers: 8, duration: "15–30 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  {
    id: "10000023", name: "Kings Cup", categoryId: "cat-cards",
    description: "Draw a card, follow its rule. Every card has a different action. When the 4th King is drawn, whoever drew it must drink the communal Kings Cup in the center.",
    steps: [
      { num: 1, title: "Set up", desc: "Place a large cup in the center. Spread a full deck face-down around it. Everyone has their own drink." },
      { num: 2, title: "Draw and act", desc: "Take turns drawing cards. Each card has a rule: Ace = Waterfall, 2 = You pick someone to drink, 3 = You drink, 4 = Everyone touches the floor (last one drinks), 5 = Guys drink, 6 = Girls drink." },
      { num: 3, title: "More rules", desc: "7 = Heaven (point up — last person drinks), 8 = Pick a Mate who drinks with you all game, 9 = Rhyme (say a word, go around rhyming — first to fail drinks), 10 = Categories." },
      { num: 4, title: "Face cards", desc: "Jack = Make a new rule that lasts the whole game. Queen = Question master — if you answer a question without asking one back, you drink. King = Pour some of your drink into the Kings Cup." },
      { num: 5, title: "The Kings Cup", desc: "The first three Kings are just pours. The player who draws the 4th King must drink the entire Kings Cup, ending the game." },
      { num: 6, title: "Substitute", desc: "Players can substitute any alcoholic drink for a non-alcoholic one at any time." },
    ],
    whatYouNeed: ["Standard 52-card deck", "A large cup for the center", "Drinks"],
    minPlayers: 3, maxPlayers: 99, duration: "30–60 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  {
    id: "10000024", name: "Horse Race", categoryId: "cat-cards",
    description: "Bet on an Ace suit and watch the race unfold card by card. The Ace that crosses the finish line first wins the pot — losers drink based on how far their horse fell short.",
    steps: [
      { num: 1, title: "Set the track", desc: "Line up the 4 Aces face-up in a column (the starting gate). Lay 8 cards face-down in a row beside them — these are the track spaces." },
      { num: 2, title: "Place bets", desc: "Before the race, each player bets on a suit (Hearts, Diamonds, Clubs, Spades). Bets can be sips, shots, or points." },
      { num: 3, title: "Run the race", desc: "The dealer flips track cards one by one. When a card is flipped, the Ace matching its suit advances one space up the track." },
      { num: 4, title: "Off the track", desc: "If an Ace runs off the end of the 8-space track, it falls back to start — and the dealer flips the next face-down track card to add to the course." },
      { num: 5, title: "Win the race", desc: "The first Ace to reach the finish line wins. Players who bet on that suit win the pot." },
      { num: 6, title: "Drink by distance", desc: "Losing players drink based on how many spaces short their horse finished. Closer to the finish = fewer sips." },
    ],
    whatYouNeed: ["Standard 52-card deck", "Drinks"],
    minPlayers: 4, maxPlayers: 8, duration: "15–30 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  {
    id: "10000025", name: "Fuck You", categoryId: "cat-cards",
    description: "A Pyramid variant with extra attitude. Memorize your cards, then assign drinks as the pyramid is revealed — but bluffing is part of the game, and getting caught costs double.",
    steps: [
      { num: 1, title: "Build the grid", desc: "Lay out a 5×5 grid of cards face-down. Deal 4 cards to each player to memorize, then place face-down." },
      { num: 2, title: "Memorize your hand", desc: "Look at your 4 cards carefully, then place them face-down. You'll need to remember them to bluff convincingly." },
      { num: 3, title: "Flip grid cards row by row", desc: "Flip cards one at a time, row by row. Row 1 = 1 drink assigned, Row 2 = 2, and so on up to Row 5." },
      { num: 4, title: "Assign drinks", desc: "Any player who claims to have a matching card in their hand may assign drinks worth that row's value to any player." },
      { num: 5, title: "Fuck you — call the bluff", desc: "The assigned player says 'Fuck you' to challenge. Bluffer revealed = bluffer drinks double. Real match = challenger drinks double." },
      { num: 6, title: "End of grid", desc: "After all 25 cards, players must drink for any unmatchable cards remaining in their hand. Substitute non-alcoholic drinks freely." },
    ],
    whatYouNeed: ["Standard 52-card deck", "Drinks"],
    minPlayers: 3, maxPlayers: 8, duration: "20–40 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  {
    id: "10000026", name: "Cheers to the Governor", categoryId: "cat-cards",
    description: "Count to 21 around the circle. When you reach 21, everyone cheers. Then the person who said 21 replaces a number with a new rule. Mess up and you drink.",
    steps: [
      { num: 1, title: "Start counting", desc: "Sit in a circle. The first person says '1', the next says '2', and so on up to 21. Go at a steady pace." },
      { num: 2, title: "Cheer at 21", desc: "When someone reaches 21, everyone cheers and drinks. That person then replaces any number in the sequence with a new rule (e.g. 'instead of 7, everyone claps')." },
      { num: 3, title: "New rule takes effect", desc: "From now on, when the count reaches that number, players must do the action instead of saying the number." },
      { num: 4, title: "Mess up = drink", desc: "Say the wrong number, forget a rule, hesitate too long, or say a number when you should do an action — you drink and the count resets to 1." },
      { num: 5, title: "Keep adding rules", desc: "Each time 21 is reached, another number gets replaced. By the end, almost every number is a different action." },
      { num: 6, title: "No winner", desc: "There's no formal winner — just play until the chaos gets unmanageable or everyone has had enough. Substitute non-alcoholic drinks freely." },
    ],
    whatYouNeed: ["Drinks", "Good memory"],
    minPlayers: 4, maxPlayers: 99, duration: "10–20 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  // ── MIND GAMES ───────────────────────────────────────────────────────────

  {
    id: "20000001", name: "Two Truths & a Lie", categoryId: "cat-mind",
    description: "Each person makes three statements about themselves — two true, one false. Everyone else votes on which is the lie. Great for getting to know people.",
    steps: [
      { num: 1, title: "Write three statements", desc: "Each player privately writes two true things and one lie about themselves. Keep them convincing — the lie should sound plausible." },
      { num: 2, title: "Read them out", desc: "One at a time, each player reads their three statements aloud in any order." },
      { num: 3, title: "Everyone votes", desc: "Other players vote on which statement they think is the lie — all at the same time to avoid influence." },
      { num: 4, title: "Reveal", desc: "The player reveals the lie. Anyone who guessed wrong loses a point. Anyone who guessed right gains one." },
      { num: 5, title: "Rotate and repeat", desc: "Move to the next player. Play until everyone has gone once." },
    ],
    whatYouNeed: ["Paper and pen (optional)", "Nothing required to play"],
    minPlayers: 3, maxPlayers: 99, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "20000002", name: "Never Have I Ever", categoryId: "cat-mind",
    description: "Take turns saying things you've never done. Everyone who has done it takes a point (or a sip). Learn way too much about your friends.",
    steps: [
      { num: 1, title: "Set up fingers or points", desc: "Each player holds up 10 fingers or starts with 10 points." },
      { num: 2, title: "Make a statement", desc: "One player says 'Never have I ever...' followed by something they have never done." },
      { num: 3, title: "Respond", desc: "Anyone who has done that thing puts a finger down (or loses a point)." },
      { num: 4, title: "Explain (optional)", desc: "Players who put a finger down can choose to explain — or keep quiet." },
      { num: 5, title: "Rotate and continue", desc: "Move clockwise. The first player to lose all 10 fingers or points is out." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 3, maxPlayers: 99, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "20000003", name: "Mafia", categoryId: "cat-mind",
    description: "An elimination game of hidden roles, deduction, and betrayal. The Mafia secretly eliminate townspeople each night; the Town tries to uncover who the Mafia are during the day.",
    steps: [
      { num: 1, title: "Assign roles", desc: "A moderator assigns roles secretly: Mafia (roughly 1 per 4 players), Doctor, Detective, and Townspeople. Use cards or slips of paper." },
      { num: 2, title: "Night phase", desc: "Everyone closes their eyes. Moderator taps Mafia members who silently agree on a victim. Then the Doctor points to someone to save. Then the Detective points to someone to investigate." },
      { num: 3, title: "Morning announcement", desc: "Everyone opens eyes. Moderator announces who was eliminated (unless the Doctor saved them) without revealing roles." },
      { num: 4, title: "Day discussion", desc: "Players discuss and accuse. Anyone can argue who they think the Mafia is. No rules — bluff freely." },
      { num: 5, title: "Vote and eliminate", desc: "Players vote to eliminate one suspect. Majority rules. The eliminated player reveals their role." },
      { num: 6, title: "Win condition", desc: "Mafia wins when they equal or outnumber the Town. Town wins when all Mafia members are eliminated." },
    ],
    whatYouNeed: ["Role cards or slips of paper", "A moderator who doesn't play"],
    minPlayers: 6, maxPlayers: 20, duration: "30–60 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "20000004", name: "Would You Rather", categoryId: "cat-mind",
    description: "Pose impossible dilemmas and debate the choices. No right answers — just opinions, arguments, and too much insight into how people think.",
    steps: [
      { num: 1, title: "Set up", desc: "No setup needed. Sit in a circle and designate who goes first." },
      { num: 2, title: "Pose a dilemma", desc: "One player asks 'Would you rather [A] or [B]?' Make both options uncomfortable or interesting." },
      { num: 3, title: "Everyone answers simultaneously", desc: "Count down and everyone points left for A or right for B at the same time." },
      { num: 4, title: "Debate", desc: "Players on each side argue why their choice is better. No time limit — debate until it's settled." },
      { num: 5, title: "Rotate", desc: "The next player clockwise poses the next dilemma." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 3, maxPlayers: 99, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  // ── RIDDLES ──────────────────────────────────────────────────────────────

  {
    id: "30000001", name: "20 Questions", categoryId: "cat-riddles",
    description: "One person thinks of anything — a person, place, or object. The group gets exactly 20 yes-or-no questions to figure it out.",
    steps: [
      { num: 1, title: "Think of something", desc: "One player secretly thinks of a person, place, animal, or object. Tell no one." },
      { num: 2, title: "Announce the category", desc: "Say whether it is a person, place, animal, object, or leave it as 'anything'." },
      { num: 3, title: "Ask yes/no questions", desc: "Players take turns asking one yes-or-no question each. The thinker answers truthfully." },
      { num: 4, title: "Track the count", desc: "Keep a shared count of questions asked. You only have 20 total." },
      { num: 5, title: "Guess or lose", desc: "Any player can guess the answer on their turn instead of asking a question. If the group hasn't guessed by question 20, the thinker wins." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 2, maxPlayers: 99, duration: "5–15 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "30000002", name: "I Spy", categoryId: "cat-riddles",
    description: "Spot something in the room and give a one-letter clue. Everyone else looks around and guesses what you're thinking of.",
    steps: [
      { num: 1, title: "Spot something", desc: "One player looks around the room and silently chooses something visible to everyone." },
      { num: 2, title: "Give the clue", desc: "Say: 'I spy with my little eye, something beginning with [letter].'" },
      { num: 3, title: "Guess", desc: "Other players take turns guessing objects that start with that letter." },
      { num: 4, title: "Confirm or deny", desc: "The spy says yes or no to each guess." },
      { num: 5, title: "Rotate", desc: "Whoever guesses correctly becomes the next spy." },
    ],
    whatYouNeed: ["Nothing — just a shared space"],
    minPlayers: 2, maxPlayers: 99, duration: "5–15 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "30000003", name: "How Many Horses", categoryId: "cat-riddles",
    description: "Knock on the table some number of times, then ask 'How many horses are there?' The trick: the answer has nothing to do with knocking — it's the number of words in your question.",
    steps: [
      { num: 1, title: "Set up the riddle", desc: "One player (who knows the secret) knocks on the table some number of times — it doesn't matter how many." },
      { num: 2, title: "Ask the question", desc: "After knocking, ask 'How many horses are there?' (4 words in the question → answer is 4) or vary the phrasing." },
      { num: 3, title: "Players guess a number", desc: "Other players try to guess the answer. They'll likely count the knocks — that's the misdirection." },
      { num: 4, title: "Reveal and replay", desc: "Reveal whether they're right or wrong. Play again with a different number of words in your question." },
      { num: 5, title: "The secret", desc: "The answer is always the number of words in your spoken question. The knocking is completely irrelevant." },
    ],
    whatYouNeed: ["Nothing — just a surface to knock on"],
    minPlayers: 2, maxPlayers: 99, duration: "5–10 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "30000004", name: "Green Glass Door", categoryId: "cat-riddles",
    description: "Some things can go through the green glass door — some can't. The pattern is hidden. Say 'a puppy can go through, but not a dog' and watch people lose their minds.",
    steps: [
      { num: 1, title: "Introduce the door", desc: "Tell players: 'There is a green glass door. Some things can go through it — some things can't. Figure out the rule.'" },
      { num: 2, title: "Give examples", desc: "Start with clear examples: 'A kitten can go through, but a cat cannot. A coffee can go through, but tea cannot. A grass lawn can go through, but a park cannot.'" },
      { num: 3, title: "Players guess items", desc: "Players take turns naming things and asking if they can go through. You confirm or deny without explaining." },
      { num: 4, title: "The rule", desc: "Only words with double consecutive letters can go through the green glass door: coffee (ff), grass (ss), puppy (pp). No double letters = can't go through." },
      { num: 5, title: "Variations", desc: "Once someone figures it out, let them host the next round with a different pattern they invent — e.g., only things with silent letters, only palindromes, etc." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 2, maxPlayers: 99, duration: "5–15 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "30000005", name: "Black Magic", categoryId: "cat-riddles",
    description: "Two players are in on it. One leaves the room, the group picks an object. When the insider asks questions, they signal the answer by mentioning a black object first.",
    steps: [
      { num: 1, title: "Two people know the secret", desc: "Two players know how the trick works. One (the guesser) leaves the room. The group picks any object in the room." },
      { num: 2, title: "The guesser returns", desc: "The insider starts asking 'Is it [object]?' pointing to random objects. The guesser says 'No' each time." },
      { num: 3, title: "The signal", desc: "Before pointing to the correct object, the insider points to any black-colored object. This is the secret signal." },
      { num: 4, title: "The next object is the answer", desc: "The guesser knows: the object immediately after the black one is the correct answer. They say 'Yes!'" },
      { num: 5, title: "The audience reacts", desc: "The group is baffled. Let them try to guess how it works. Accept variations — white objects, even numbers of questions, etc." },
    ],
    whatYouNeed: ["Nothing — just a room with objects"],
    minPlayers: 2, maxPlayers: 99, duration: "5–10 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "30000006", name: "4 is the Magic Number", categoryId: "cat-riddles",
    description: "Any number you say will always converge to 4 — because 4 is the only number where the letter count equals the number itself. Watch people try to break it.",
    steps: [
      { num: 1, title: "Ask for a number", desc: "Ask someone to give you any number." },
      { num: 2, title: "Count the letters", desc: "Say that number's name and count its letters, then say the next number's name and count those letters, chaining until you reach 4." },
      { num: 3, title: "Demo", desc: "Example: 'Ten is 3. Three is 5. Five is 4. Four is 4. Four is always 4.' Try: 'One hundred is 10. Ten is 3. Three is 5. Five is 4.'" },
      { num: 4, title: "The rule", desc: "4 is the only number in English where the count of letters exactly equals the number itself: F-O-U-R = 4 letters = 4. Every chain converges to 4." },
      { num: 5, title: "Let them try to escape", desc: "Let players pick giant numbers, negative numbers, or fractions. It always comes back to 4. Have them figure out why." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 2, maxPlayers: 99, duration: "5–10 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "30000007", name: "Good Line / Bad Line", categoryId: "cat-riddles",
    description: "Draw random lines in the air and declare them good or bad. Players try to figure out the pattern. The trick: anything with 'um' before it is a bad line.",
    steps: [
      { num: 1, title: "Introduce the game", desc: "Tell players you'll draw lines in the air and declare each one good or bad. They have to figure out the rule." },
      { num: 2, title: "Draw and label", desc: "Draw any shape or line and say 'This is a good line' or 'Um, this is a bad line.' Vary the lines wildly — long, short, squiggly, straight." },
      { num: 3, title: "The secret", desc: "If you say 'um' (or any filler word) before your declaration, it's a bad line. If you don't, it's a good line. The actual drawing is irrelevant." },
      { num: 4, title: "Players guess", desc: "Let players study your lines and guess the rule. They'll obsess over the shapes. Let them guess — confirm only if correct." },
      { num: 5, title: "Once discovered", desc: "Anyone who figures it out can secretly join you in drawing lines, helping confuse others. Keep it going until everyone knows." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 2, maxPlayers: 99, duration: "5–10 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "30000008", name: "Is It Open or Closed", categoryId: "cat-riddles",
    description: "Show an object that can be opened or closed. The trick isn't about the object — it's about whether your mouth is open or closed when you ask the question.",
    steps: [
      { num: 1, title: "Pick an object", desc: "Hold any object that can be open or closed — a water bottle, a clip, a book, a jar. Open and close it a few times to set expectations." },
      { num: 2, title: "Set the position and ask", desc: "Hold the object in some position (open or closed — doesn't matter) and ask: 'Is it open or closed?'" },
      { num: 3, title: "The secret", desc: "The answer depends entirely on whether your mouth is open or closed when you ask the question — not the object. If your mouth is open, the answer is open. If it's closed, the answer is closed." },
      { num: 4, title: "Confirm answers", desc: "Players guess based on the object position. Confirm right or wrong without explaining. Let them notice the pattern." },
      { num: 5, title: "Let them try", desc: "Once someone guesses it, let them run the trick on someone else in the group." },
    ],
    whatYouNeed: ["Any object that can be opened or closed (bottle, clip, book, etc.)"],
    minPlayers: 2, maxPlayers: 99, duration: "5–10 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  // ── WORD GAMES ───────────────────────────────────────────────────────────

  {
    id: "40000001", name: "Word Association", categoryId: "cat-word",
    description: "Say the first word that comes to mind based on the previous word. Hesitate, repeat a word, or say something unrelated and you're out.",
    steps: [
      { num: 1, title: "Start with a word", desc: "One player says any word to start the chain." },
      { num: 2, title: "Respond instantly", desc: "The next player immediately says a word associated with the previous one. No pausing to think." },
      { num: 3, title: "Keep it moving", desc: "Continue around the circle at speed. The association must be obvious enough that the group can see the link." },
      { num: 4, title: "Challenge and eliminate", desc: "If a player hesitates, repeats a word, or makes a link no one understands, they are out. Group votes on whether a link is acceptable." },
      { num: 5, title: "Win", desc: "Last player standing wins." },
    ],
    whatYouNeed: ["Nothing"],
    minPlayers: 3, maxPlayers: 99, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "40000002", name: "Ghost", categoryId: "cat-word",
    description: "Build a word one letter at a time without completing a real word. The player who finishes a word gets a letter: G-H-O-S-T. Spell GHOST and you're out.",
    steps: [
      { num: 1, title: "Start a word", desc: "The first player says any single letter to begin building a word." },
      { num: 2, title: "Add a letter", desc: "Each player adds one letter to the chain. You must have a real word in mind — you cannot play randomly." },
      { num: 3, title: "Avoid completing a word", desc: "If the letters you've spelled form a complete dictionary word of 4+ letters, you get a letter in GHOST." },
      { num: 4, title: "Challenge", desc: "If you doubt someone has a real word in mind, challenge them. They must say the word. If they can't, they get a letter. If they can, the challenger gets a letter." },
      { num: 5, title: "Spell GHOST and lose", desc: "The first player to collect all 5 letters (G-H-O-S-T) is eliminated. Play until one player remains." },
    ],
    whatYouNeed: ["Nothing"],
    minPlayers: 3, maxPlayers: 8, duration: "10–20 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "40000003", name: "Categories", categoryId: "cat-word",
    description: "Name things in a given category while keeping a beat. Miss the beat or repeat an answer and you're out.",
    steps: [
      { num: 1, title: "Set the beat", desc: "Everyone slaps their knees twice then claps twice repeatedly to keep a steady rhythm." },
      { num: 2, title: "Name the category", desc: "On the clap, one player names a category (e.g. 'Countries in Europe', 'Ice cream flavors')." },
      { num: 3, title: "Name something in it", desc: "On each subsequent clap, the next player must say something in that category — one word, on the beat." },
      { num: 4, title: "No repeats, no hesitation", desc: "You cannot repeat an answer already said. If you hesitate past the beat or repeat, you're out." },
      { num: 5, title: "Win", desc: "Last player still going wins and picks the next category." },
    ],
    whatYouNeed: ["Nothing"],
    minPlayers: 3, maxPlayers: 99, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "40000004", name: "Wavelength", categoryId: "cat-word",
    description: "One player closes their eyes while the group picks a number. Then they open their eyes and give each person a category — the answers should help them guess the number.",
    steps: [
      { num: 1, title: "Close your eyes", desc: "One player (the guesser) closes their eyes. The rest of the group secretly picks a number from 1 to 100 (or any agreed range)." },
      { num: 2, title: "Open your eyes and assign categories", desc: "The guesser opens their eyes. They go around the circle giving each person a category — any category at all (e.g., 'favorite restaurant in NYC,' 'a movie that scared you,' 'something you'd see on a Tuesday')." },
      { num: 3, title: "Everyone answers", desc: "Each person answers their category with the first thing that comes to mind. The answer should help the guesser figure out the number." },
      { num: 4, title: "Guesser makes their guess", desc: "After hearing all answers, the guesser makes their number guess based on the vibe of the responses." },
      { num: 5, title: "Reveal and discuss", desc: "Reveal the actual number. Discuss how each answer pointed toward (or away from) it. Score points based on proximity to the target." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 4, maxPlayers: 12, duration: "Open-ended", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "40000005", name: "Psychiatrist", categoryId: "cat-word",
    description: "One person steps out of the room. The remaining group adopts a secret shared rule. The outsider comes back and asks yes/no questions to figure out the rule.",
    steps: [
      { num: 1, title: "Pick the psychiatrist", desc: "One player (the psychiatrist) leaves the room or covers their ears." },
      { num: 2, title: "Make a rule", desc: "The remaining players secretly agree on a rule that changes how they answer. Examples: 'We answer as if we are the person to our left,' 'We lie if we're wearing shoes,' 'We only speak in questions.'" },
      { num: 3, title: "The psychiatrist returns", desc: "The psychiatrist comes back and begins interviewing players with any questions they like to figure out the secret rule." },
      { num: 4, title: "Answer according to the rule", desc: "All players answer honestly within the constraints of the rule. Don't give it away too easily." },
      { num: 5, title: "Guess the rule", desc: "The psychiatrist can guess the rule at any time. If correct, the round ends and a new psychiatrist is chosen. If wrong, questioning continues." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 4, maxPlayers: 99, duration: "Open-ended", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "40000006", name: "Essence", categoryId: "cat-word",
    description: "Think of one person in the group secretly. Everyone asks you 'essence' questions — if this person were a color, a season, a type of food — and tries to guess who you're thinking of.",
    steps: [
      { num: 1, title: "Pick a person", desc: "One player secretly thinks of someone in the group. Don't reveal who." },
      { num: 2, title: "Ask essence questions", desc: "Other players take turns asking questions about the person's 'essence.' Examples: 'If this person were a type of weather, what would they be?' 'A meal?' 'A time of day?' 'A sound?'" },
      { num: 3, title: "Answer honestly", desc: "Answer each question based on how you truly feel the chosen person embodies that thing. Don't be too literal or too abstract." },
      { num: 4, title: "Ask 6 questions", desc: "After 6 questions have been asked, the group makes their guesses simultaneously." },
      { num: 5, title: "Reveal and discuss", desc: "Reveal who you were thinking of. Discuss which answers gave it away and which were surprising." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 4, maxPlayers: 99, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "40000007", name: "Connection 3-2-1", categoryId: "cat-word",
    description: "Two players count down from 3 and simultaneously say a word. Then they count down again and try to converge on the same word. Keep going until both say the same word.",
    steps: [
      { num: 1, title: "Pair up", desc: "Two players face each other. Everyone else watches." },
      { num: 2, title: "First words — 3-2-1", desc: "Count down together: '3, 2, 1' — both players say any word simultaneously." },
      { num: 3, title: "Find the connection", desc: "Look at the two words said. Think about what concept connects them." },
      { num: 4, title: "Converge — 3-2-1", desc: "Count down again. Both players say a new word simultaneously that bridges the previous two words. The goal is to say the same word." },
      { num: 5, title: "Keep going", desc: "Repeat until both players say the exact same word on the countdown. Count how many rounds it took." },
      { num: 6, title: "Win", desc: "Try to beat your record. Play multiple pairs. The pair that converges in the fewest rounds wins." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 2, maxPlayers: 99, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "40000008", name: "Contact", categoryId: "cat-word",
    description: "One person thinks of a word. Others try to 'make contact' by thinking of the same word as each other from a clue — without the word-holder guessing it first.",
    steps: [
      { num: 1, title: "Word holder picks a word", desc: "One player (the word holder) thinks of a word and reveals only the first letter." },
      { num: 2, title: "Give a clue", desc: "Another player gives a vague clue for a word starting with that letter — one the word holder may not guess. Example: for 'C' — 'It's a vegetable.'" },
      { num: 3, title: "Word holder guesses", desc: "The word holder tries to guess what word the clue refers to. If they guess correctly before anyone says 'Contact,' the round continues." },
      { num: 4, title: "Make contact", desc: "If two other players both think they know the clue word, they count down '3-2-1 Contact' and say their answer simultaneously. If they match, the word holder must reveal the next letter." },
      { num: 5, title: "Reveal letters until guessed", desc: "Keep revealing letters until someone guesses the full word or the word holder concedes." },
      { num: 6, title: "Win", desc: "The player who correctly guesses the full word becomes the new word holder." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 3, maxPlayers: 99, duration: "Open-ended", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  // ── DICE GAMES ───────────────────────────────────────────────────────────

  {
    id: "50000001", name: "Farkle", categoryId: "cat-dice",
    description: "Roll six dice and bank scoring combinations. But if you roll no scoring dice, you Farkle and lose everything accumulated that turn.",
    steps: [
      { num: 1, title: "Roll all six dice", desc: "On your turn, roll all six dice." },
      { num: 2, title: "Set aside scoring dice", desc: "Set aside at least one scoring die. 1s = 100pts, 5s = 50pts, three of a kind = number × 100 (three 1s = 1000pts)." },
      { num: 3, title: "Roll again or bank", desc: "Roll the remaining dice or bank your points. Banking ends your turn and locks in your score." },
      { num: 4, title: "Farkle = lose it all", desc: "If no dice score on any roll, you Farkle — lose all points accumulated that turn and play passes left." },
      { num: 5, title: "Hot dice", desc: "If all six dice are scoring, pick them all up and roll again to keep building." },
      { num: 6, title: "Win", desc: "First player to reach 10,000 points and survive a final round of challenges wins." },
    ],
    whatYouNeed: ["6 standard dice", "Pen and paper for scoring"],
    minPlayers: 2, maxPlayers: 8, duration: "20–40 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "50000002", name: "Yahtzee", categoryId: "cat-dice",
    description: "Roll five dice up to three times per turn to score specific combinations. Fill your scorecard in 13 rounds. Highest total wins.",
    steps: [
      { num: 1, title: "Roll all five dice", desc: "On your turn, roll all five dice to start." },
      { num: 2, title: "Keep and re-roll", desc: "Set aside any dice you want to keep. Roll the rest. You can re-roll up to twice more per turn." },
      { num: 3, title: "Choose a scoring category", desc: "After your final roll, mark one category on your scorecard. You must fill one category per turn even if it scores zero." },
      { num: 4, title: "Score combinations", desc: "Upper section: sum of each number (1s through 6s). Lower section: Three of a Kind, Four of a Kind, Full House (25), Small Straight (30), Large Straight (40), Chance, Yahtzee (50)." },
      { num: 5, title: "Yahtzee bonus", desc: "If you roll a Yahtzee and have already scored it, mark a bonus 100 points on the back of the card." },
      { num: 6, title: "Win", desc: "After 13 rounds all categories are filled. Add up totals — bonus 35 points if upper section totals 63+. Highest score wins." },
    ],
    whatYouNeed: ["5 dice", "Yahtzee scorecard (or paper)", "Pen"],
    minPlayers: 2, maxPlayers: 6, duration: "30–45 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  // ── DRINKING GAMES (NON-CARD) ─────────────────────────────────────────────

  {
    id: "60000001", name: "Beer Pong", categoryId: "cat-drinking",
    description: "Throw a ping pong ball across the table and try to land it in the opposing team's cups. Sink a cup, they drink it. Clear their side first to win.",
    steps: [
      { num: 1, title: "Set up", desc: "Arrange 10 cups in a triangle formation on each end of a long table. Fill each cup with a small amount of beer (or any drink). Each team stands at their end." },
      { num: 2, title: "Shoot", desc: "Teams take turns throwing a ping pong ball toward the opponent's cups. Each team gets 2 shots per turn (one per player). Elbows must stay behind the table edge." },
      { num: 3, title: "Drink and remove", desc: "When a ball lands in a cup, the opposing team drinks it and removes the cup from the table." },
      { num: 4, title: "Re-racks", desc: "Each team can request 2 re-racks per game — rearranging remaining cups into a tighter formation." },
      { num: 5, title: "Redemption", desc: "When the last cup is sunk, the losing team gets a redemption round — they shoot until they miss. If they clear the remaining cups, the game goes to overtime with 3 cups each." },
      { num: 6, title: "Win", desc: "First team to eliminate all of the opponent's cups wins. Substitute non-alcoholic drinks freely." },
    ],
    whatYouNeed: ["20 solo cups", "2 ping pong balls", "A long table", "Drinks"],
    minPlayers: 4, maxPlayers: 4, duration: "20–40 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  {
    id: "60000002", name: "Up Chicken Down Chicken", categoryId: "cat-drinking",
    description: "A quarter bouncing game with two commands. Bounce a quarter into a cup. The person across from you either drinks up or drinks down depending on the call.",
    steps: [
      { num: 1, title: "Set up", desc: "Sit in a circle. Place a cup in the center with a small amount of drink. One player starts with a quarter." },
      { num: 2, title: "Bounce the quarter", desc: "The active player bounces the quarter off the table, trying to land it in the cup." },
      { num: 3, title: "Make the call", desc: "Before bouncing, the player says 'Up Chicken' or 'Down Chicken.' Up = the person to their left must drink if it lands. Down = the person to their right." },
      { num: 4, title: "Miss = pass", desc: "If the quarter misses, the quarter passes to the left. No drinks on a miss." },
      { num: 5, title: "Land it = drink", desc: "If the quarter lands in the cup, the designated 'chicken' must drink and the shooter goes again." },
      { num: 6, title: "Keep going", desc: "Play continues until everyone has had their fill. Substitute non-alcoholic drinks freely." },
    ],
    whatYouNeed: ["A quarter", "Solo cups", "Drinks"],
    minPlayers: 3, maxPlayers: 10, duration: "15–30 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  {
    id: "60000003", name: "7/11 or Doubles", categoryId: "cat-drinking",
    description: "Roll two dice. If you get 7, 11, or doubles, someone drinks — but they have to pick up the cup before you re-roll. Race the dice every single turn.",
    steps: [
      { num: 1, title: "Set up", desc: "Fill a cup with a drink and place it in the center of the table. One player starts with the dice." },
      { num: 2, title: "Roll", desc: "The active player rolls both dice. If the result is 7, 11, or any doubles, they point to someone who must drink." },
      { num: 3, title: "Pick up and race", desc: "The chosen player picks up the cup and starts drinking. The roller immediately re-rolls as fast as possible." },
      { num: 4, title: "Put it down to stop", desc: "The drinker can only stop when the cup is back on the table. But if the roller hits 7, 11, or doubles again before the cup is down, the drinker must drink more." },
      { num: 5, title: "Pass the dice", desc: "Once the cup is back on the table, the dice pass to the left. If the roller misses (no 7, 11, or doubles), dice pass immediately." },
      { num: 6, title: "Keep playing", desc: "Continue until everyone's had enough. Substitute non-alcoholic drinks freely." },
    ],
    whatYouNeed: ["2 dice", "A cup", "Drinks"],
    minPlayers: 3, maxPlayers: 8, duration: "Open-ended", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  {
    id: "60000004", name: "Beer Ball", categoryId: "cat-drinking",
    description: "Two teams race to finish their beers. Throw a ping pong ball at the opposing team's cans — when you hit one, chug until they retrieve the ball and tap the table.",
    steps: [
      { num: 1, title: "Set up", desc: "Two teams of 2 face each other across a table. Each player places their unopened can in front of them at the table edge." },
      { num: 2, title: "Throw the ball", desc: "Teams alternate throwing a ping pong ball at the opposing team's cans. You're aiming to hit the cans." },
      { num: 3, title: "Hit a can — chug", desc: "When a can is hit, that player opens it (or picks it up if already open) and chugs continuously while the other team retrieves the ball." },
      { num: 4, title: "Stop chugging", desc: "The chugging stops the moment the throwing team retrieves the ball and one player taps it on the table." },
      { num: 5, title: "Miss = no drink", desc: "If the throw misses all cans, no one drinks and the other team throws." },
      { num: 6, title: "Win", desc: "First team to finish both of their cans wins. Substitute non-alcoholic drinks freely." },
    ],
    whatYouNeed: ["4 cans of beer (or canned drinks)", "1 ping pong ball", "A table"],
    minPlayers: 4, maxPlayers: 4, duration: "20–40 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  {
    id: "60000005", name: "Musical Flip Cup", categoryId: "cat-drinking",
    description: "Flip cup meets musical chairs. When the music stops, two players face off in a flip cup duel. Loser is eliminated. Last one standing wins.",
    steps: [
      { num: 1, title: "Set up", desc: "Fill cups halfway with drink and arrange them in a circle around a table — one cup fewer than the number of players. Everyone stands around the table." },
      { num: 2, title: "Music plays, walk around", desc: "Play music. Players walk around the table. When the music stops, everyone rushes to grab a cup." },
      { num: 3, title: "Flip cup duel", desc: "The one player left without a cup must flip cup against their nearest neighbor. Each drinks then flips their cup from the table edge using one finger." },
      { num: 4, title: "Loser is eliminated", desc: "First to flip successfully wins. Loser is out and one more cup is removed." },
      { num: 5, title: "Repeat", desc: "Restart the music. Keep going until two players remain." },
      { num: 6, title: "Final showdown", desc: "Final two players do a best-of-3 flip cup duel. Winner takes the game. Substitute non-alcoholic drinks freely." },
    ],
    whatYouNeed: ["Solo cups", "Music source", "Drinks"],
    minPlayers: 6, maxPlayers: 99, duration: "15–30 min", difficulty: "Easy",
    isDrinking: true, isLibrary: true
  },

  // ── PARTY GAMES ──────────────────────────────────────────────────────────

  {
    id: "70000001", name: "Couch Game", categoryId: "cat-party",
    description: "Two teams compete to fill the couch. One team is on the couch, one is on the floor. Say a teammate's name and they swap seats — but the other team is trying to block you.",
    steps: [
      { num: 1, title: "Set up teams", desc: "Split into 2 equal teams. One team sits on the couch with one empty seat next to them. The other team sits on the floor or chairs nearby." },
      { num: 2, title: "Fill the empty seat", desc: "The team on the couch tries to fill the empty seat by calling a teammate's name. That teammate immediately moves to the empty seat." },
      { num: 3, title: "Blocking", desc: "The floor team tries to sit in the empty seat before the named couch player can move. If they succeed, they take the seat and a floor player is now on the couch." },
      { num: 4, title: "Keep moving", desc: "Calling a name always creates a new empty seat where the named player was sitting. Both teams react simultaneously." },
      { num: 5, title: "Win", desc: "The couch team wins when all their players are on the couch. The floor team wins if they take over the couch entirely." },
    ],
    whatYouNeed: ["A couch", "Chairs or floor space"],
    minPlayers: 6, maxPlayers: 20, duration: "20–40 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "70000002", name: "Do You Like Your Neighbors", categoryId: "cat-party",
    description: "One person stands in the middle and asks someone 'Do you like your neighbors?' Say no and chaos breaks out. A deceptively simple game that gets wild fast.",
    steps: [
      { num: 1, title: "Set up", desc: "Sit in a circle with chairs, one per person. One person stands in the middle with no chair." },
      { num: 2, title: "Ask a neighbor question", desc: "The middle person asks anyone: 'Do you like your neighbors?' The answer determines what happens next." },
      { num: 3, title: "Yes — neighbors swap", desc: "If you say 'Yes,' your two immediate neighbors must swap seats. The middle person tries to steal one of those seats." },
      { num: 4, title: "No — everyone with [trait] moves", desc: "If you say 'No,' you say who you do like — e.g., 'I like people who are wearing blue.' Everyone fitting that description must stand up and find a new seat. Middle person also grabs a seat." },
      { num: 5, title: "New middle person", desc: "Whoever doesn't get a seat becomes the new middle person." },
    ],
    whatYouNeed: ["Chairs (one fewer than players)"],
    minPlayers: 5, maxPlayers: 20, duration: "10–20 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "70000003", name: "Kingdom / Empire", categoryId: "cat-party",
    description: "Write a famous person's name on a sticky note and put it on someone else's forehead. Ask yes/no questions to figure out who you are.",
    steps: [
      { num: 1, title: "Write names", desc: "Each player writes the name of a famous person (real or fictional) on a sticky note or piece of paper." },
      { num: 2, title: "Stick it on someone else", desc: "Pass your note to another player who sticks it on their forehead without looking. Everyone can see your name except you." },
      { num: 3, title: "Ask yes/no questions", desc: "Take turns asking the group yes/no questions to narrow down who you are. 'Am I alive?' 'Am I in sports?' 'Am I American?'" },
      { num: 4, title: "Correct guess = go again", desc: "If you guess correctly, you can remove your note and keep asking questions to try to guess a second identity (or just relax and help others)." },
      { num: 5, title: "Win", desc: "First player to correctly guess their identity wins. Or play until everyone has figured theirs out." },
    ],
    whatYouNeed: ["Sticky notes or paper", "Pens", "Something to stick notes to foreheads"],
    minPlayers: 4, maxPlayers: 20, duration: "20–40 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "70000004", name: "Signs", categoryId: "cat-party",
    description: "Everyone has a secret sign. One person is 'it' and tries to catch the sign being passed around the circle before it gets to them.",
    steps: [
      { num: 1, title: "Assign signs", desc: "Everyone in the circle picks a unique physical gesture (tapping nose, pulling ear, wink, etc.). Go around and learn each other's signs." },
      { num: 2, title: "It stands in the middle", desc: "One player stands in the center. They close their eyes while the group silently picks who starts with the signal." },
      { num: 3, title: "Pass the signal", desc: "Players pass the signal by making eye contact with someone and doing their sign. The recipient acknowledges with their own sign back, then becomes the new signal holder." },
      { num: 4, title: "It tries to catch it", desc: "The middle player watches for the passing signal. If they see someone performing a sign, they can accuse that player." },
      { num: 5, title: "Caught or guessed wrong", desc: "If the accusation is correct, the caught player goes to the middle. If wrong, the accuser must do a penalty (or just continue watching)." },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 5, maxPlayers: 20, duration: "15–30 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "70000005", name: "Blind Never Have I Ever", categoryId: "cat-party",
    description: "Like Never Have I Ever, but everyone puts fingers down secretly and simultaneously — no one has to admit what they've done. Then you reveal and compare.",
    steps: [
      { num: 1, title: "Hold up fingers", desc: "Everyone holds up 5 fingers (or 10) hidden from view behind their back or under the table." },
      { num: 2, title: "Make a statement", desc: "One player says 'Never have I ever...' followed by something they've never done." },
      { num: 3, title: "Put fingers down secretly", desc: "Anyone who has done that thing puts a finger down without showing anyone." },
      { num: 4, title: "Reveal simultaneously", desc: "After each statement, everyone reveals their current finger count at the same time on a count of 3." },
      { num: 5, title: "React and rotate", desc: "See who put a finger down and react accordingly — but no one has to explain themselves. Player with the fewest fingers left after all statements is the 'most experienced.'" },
    ],
    whatYouNeed: ["Nothing — just people"],
    minPlayers: 4, maxPlayers: 99, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "70000006", name: "Vollines", categoryId: "cat-party",
    description: "A beach game played in a square divided by a center line. Throw a tennis ball to the other side — the receiving team must catch it before it bounces twice. Fast, fun, and surprisingly intense.",
    steps: [
      { num: 1, title: "Draw the court", desc: "Mark out a square divided down the middle by a line (draw in sand or use tape/rope on grass). Teams stand on opposite sides." },
      { num: 2, title: "Serve", desc: "One team starts by throwing the tennis ball over the center line to the other side." },
      { num: 3, title: "Receive", desc: "The receiving team must catch the ball before it bounces twice on their side. One bounce is allowed." },
      { num: 4, title: "Throw back", desc: "After catching, throw it back over the line. Keep it within the square boundaries." },
      { num: 5, title: "Score a point", desc: "Score a point if the ball bounces twice on the opponent's side, goes out of bounds on their side, or they drop it on a valid throw." },
      { num: 6, title: "Win", desc: "First team to 11 points (win by 2) wins. Best of 3 sets recommended." },
    ],
    whatYouNeed: ["A tennis ball", "Open space (beach, grass, or gym)", "Something to mark a square court"],
    minPlayers: 4, maxPlayers: 8, duration: "15–30 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "70000007", name: "I Like People Who…", categoryId: "cat-party",
    description: "One person in the middle calls out a trait. Everyone who fits that description scrambles for a new seat — and so does the caller. Whoever doesn't find a seat is next.",
    steps: [
      { num: 1, title: "Set up", desc: "Sit in a circle with chairs, one fewer than the number of players. One player starts in the middle." },
      { num: 2, title: "Make a statement", desc: "The middle player says 'I like people who...' followed by any trait: 'have a dog,' 'are wearing socks,' 'have been to Europe,' etc." },
      { num: 3, title: "Everyone who fits it moves", desc: "Anyone who fits the description must stand up and find a new seat. They cannot sit back in their original seat." },
      { num: 4, title: "Grab a seat", desc: "The middle player also rushes to grab a seat. Whoever is left standing becomes the new middle person." },
      { num: 5, title: "Keep going", desc: "Play as many rounds as you like. The more creative the prompts, the more fun it gets." },
    ],
    whatYouNeed: ["Chairs (one fewer than players)"],
    minPlayers: 5, maxPlayers: 20, duration: "15–30 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  // ── APP GAMES ─────────────────────────────────────────────────────────────

  {
    id: "80000001", name: "Psych!", categoryId: "cat-app",
    description: "The app asks trivia questions and everyone submits a fake-but-believable answer. Then vote for the real answer among all the fakes. Fool people to score points.",
    steps: [
      { num: 1, title: "Download the app", desc: "Download the Psych! app (by Ellen DeGeneres). One player creates a game room and others join with a room code." },
      { num: 2, title: "Pick a category", desc: "The host selects a trivia category (Movie Taglines, Celebrities, History, etc.)." },
      { num: 3, title: "Submit a fake answer", desc: "The app shows a real trivia question. Every player submits a fake answer designed to sound believable." },
      { num: 4, title: "Vote for the real answer", desc: "All fake answers (plus the real one) are shown. Players vote for what they think is correct." },
      { num: 5, title: "Score", desc: "You score points for every player you fooled with your fake answer, plus bonus points if you correctly identified the real answer." },
      { num: 6, title: "Win", desc: "Play through the round. Player with the most points after all questions wins." },
    ],
    whatYouNeed: ["Psych! app (free, iOS & Android)", "1 phone per player"],
    minPlayers: 3, maxPlayers: 8, duration: "15–30 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "80000002", name: "Piccolo", categoryId: "cat-app",
    description: "A drinking game app that delivers prompts, dares, and mini-games one player at a time. The app knows everyone's names and makes it personal.",
    steps: [
      { num: 1, title: "Download and enter names", desc: "Download the Piccolo app. Enter the names of all players — the app uses them throughout." },
      { num: 2, title: "Pick a game mode", desc: "Choose from modes like Classic, Dirty, Party, or create a custom mix depending on your group's vibe." },
      { num: 3, title: "Pass the phone", desc: "Pass the phone around the circle. The person holding it reads their prompt aloud and follows it." },
      { num: 4, title: "Follow the prompt", desc: "Prompts range from drinking rules and dares to mini-games and group challenges. The app handles the pacing." },
      { num: 5, title: "Keep going", desc: "Continue passing until the game ends or everyone decides to stop. Substitute non-alcoholic drinks freely." },
    ],
    whatYouNeed: ["Piccolo app (iOS & Android)", "1 phone", "Drinks (optional)"],
    minPlayers: 3, maxPlayers: 10, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "80000003", name: "Mr. White", categoryId: "cat-app",
    description: "Almost everyone gets a secret word. One player — Mr. White — gets nothing. Describe your word without saying it. Mr. White bluffs. The group tries to unmask the imposter.",
    steps: [
      { num: 1, title: "Download and start a game", desc: "Download the Mr. White app. Everyone gets dealt a secret word — except Mr. White, who sees a blank screen." },
      { num: 2, title: "Give one clue", desc: "Go around the circle. Each player says one word or phrase to hint at their secret word without saying it. Mr. White improvises." },
      { num: 3, title: "Discuss and vote", desc: "After one full round of clues, players discuss who they think is Mr. White and vote to eliminate someone." },
      { num: 4, title: "Mr. White guesses", desc: "If Mr. White is eliminated, they get one final chance to guess the secret word. If correct, Mr. White wins." },
      { num: 5, title: "Win condition", desc: "Citizens win by correctly eliminating Mr. White before he guesses the word. Mr. White wins by surviving until only 3 players remain or by guessing the word after being caught." },
    ],
    whatYouNeed: ["Mr. White app (iOS & Android)"],
    minPlayers: 4, maxPlayers: 20, duration: "15–30 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "80000004", name: "Wikiraces", categoryId: "cat-app",
    description: "Start on one Wikipedia page and race to reach a target page using only internal hyperlinks. Whoever navigates there in the fewest clicks wins.",
    steps: [
      { num: 1, title: "Pick start and end articles", desc: "Agree on a starting Wikipedia article and a target article. The more unrelated they seem, the better." },
      { num: 2, title: "Everyone starts on the same page", desc: "All players navigate to the start article on their device simultaneously." },
      { num: 3, title: "Race to the target", desc: "Click through Wikipedia's internal links to reach the target page. You can only use links within article text — no search bar, no back button (or agree on rules before starting)." },
      { num: 4, title: "Announce your win", desc: "First player to reach the target article calls out and shows their screen." },
      { num: 5, title: "Compare paths", desc: "Everyone shares the path they took. The person with the fewest clicks wins the tiebreaker if multiple players finish close together." },
    ],
    whatYouNeed: ["A phone or browser per player", "Wikipedia access"],
    minPlayers: 2, maxPlayers: 99, duration: "5–15 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "80000005", name: "Out of the Loop", categoryId: "cat-app",
    description: "Most players get the same secret word. One player — out of the loop — gets nothing. Ask each other questions and try to identify who doesn't know the word.",
    steps: [
      { num: 1, title: "Start a round", desc: "Download the Out of the Loop app. One player starts a round — most players receive a secret word, one player sees 'You are out of the loop.'" },
      { num: 2, title: "Ask and answer", desc: "Take turns asking each other questions about the word. Keep answers vague enough to not give it away to the outsider." },
      { num: 3, title: "The outsider bluffs", desc: "The player out of the loop must answer questions confidently, guessing from context what the word might be." },
      { num: 4, title: "Vote", desc: "After a set number of questions, everyone simultaneously votes on who they think is out of the loop." },
      { num: 5, title: "Outsider guesses", desc: "If the outsider is voted out, they get one guess at the secret word. Guess correctly and they still win." },
      { num: 6, title: "Score", desc: "Outsider wins by surviving or guessing right. Everyone else wins by correctly identifying the outsider." },
    ],
    whatYouNeed: ["Out of the Loop app (iOS & Android)"],
    minPlayers: 4, maxPlayers: 20, duration: "15–30 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  // ── CAR GAMES ─────────────────────────────────────────────────────────────

  {
    id: "90000001", name: "License Plate Game", categoryId: "cat-car",
    description: "Spot license plates from different states or countries during a road trip and call them out. First to find all 50 states wins — or just compete to find the most.",
    steps: [
      { num: 1, title: "Set the goal", desc: "Decide the objective before starting: find all 50 US states, find the most plates in a set time, or collect the most unusual/distant plates." },
      { num: 2, title: "Spot and call", desc: "Any player can spot a license plate from a different state (or country) and call it out. First to call it claims it." },
      { num: 3, title: "Track your finds", desc: "Keep a running list on paper or in a notes app. Each unique state or country counts once." },
      { num: 4, title: "No double-counting", desc: "Once a state has been claimed by someone, it can't be claimed again — or play cooperatively and let everyone share the list." },
      { num: 5, title: "Win", desc: "At the end of the trip, the player with the most unique plates wins. Bonus points for Hawaii, Alaska, or international plates." },
    ],
    whatYouNeed: ["A moving vehicle", "Pen and paper or notes app (optional)"],
    minPlayers: 2, maxPlayers: 99, duration: "Open-ended", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  // ── PAPER & PEN ───────────────────────────────────────────────────────────

  {
    id: "a0000001", name: "Ultimate Tic Tac Toe", categoryId: "cat-paper",
    description: "A Tic Tac Toe game played inside another Tic Tac Toe grid. Where you play in a small square determines where your opponent must play next. Win 3 small grids in a row to win.",
    steps: [
      { num: 1, title: "Draw the board", desc: "Draw a large 3×3 grid. Inside each of the 9 cells, draw another 3×3 grid. You now have 81 small squares total." },
      { num: 2, title: "First move anywhere", desc: "The first player places their mark (X or O) in any small square within any of the 9 mini-grids." },
      { num: 3, title: "Your move determines their zone", desc: "The cell position where you played inside the mini-grid corresponds to a mini-grid on the outer board. Your opponent must play inside that mini-grid on their turn." },
      { num: 4, title: "Win a mini-grid", desc: "Win a mini-grid by getting 3 in a row within it. Mark that mini-grid with your symbol on the outer board." },
      { num: 5, title: "Sent to a won grid", desc: "If you're sent to a mini-grid that's already been won or filled, your opponent can play anywhere." },
      { num: 6, title: "Win", desc: "Win 3 mini-grids in a row on the outer board to win the game." },
    ],
    whatYouNeed: ["Paper", "Pen"],
    minPlayers: 2, maxPlayers: 2, duration: "10–20 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "a0000002", name: "Lasso", categoryId: "cat-paper",
    description: "A territory game on a dot grid. Draw lines to form complete circles (lassos) around dots. Each completed lasso scores the dots inside. Most territory wins.",
    steps: [
      { num: 1, title: "Draw a dot grid", desc: "Draw a grid of dots — 6×6 or larger works well. Players alternate turns." },
      { num: 2, title: "Connect adjacent dots", desc: "On your turn, draw one line segment connecting two adjacent dots (horizontally or vertically). Diagonal lines are not allowed." },
      { num: 3, title: "Close a lasso", desc: "If your line completes a closed loop around one or more dots, those dots are yours. Fill them in or mark them with your symbol." },
      { num: 4, title: "Extra turn on capture", desc: "Whenever you close a loop, take another turn immediately." },
      { num: 5, title: "Win", desc: "When no more lines can be drawn, count the dots inside each player's lassos. Most dots wins." },
    ],
    whatYouNeed: ["Graph paper or blank paper", "Pen"],
    minPlayers: 2, maxPlayers: 2, duration: "10–20 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "a0000003", name: "Sim", categoryId: "cat-paper",
    description: "Two players draw colored lines between 6 dots. The player who completes a triangle of their own color loses. Sounds simple — the math guarantees one of you will lose.",
    steps: [
      { num: 1, title: "Draw 6 dots in a circle", desc: "Draw 6 dots arranged in a rough hexagon or circle on paper. These are the game's nodes." },
      { num: 2, title: "Assign colors", desc: "Each player picks a color (or one draws with pen, the other with pencil)." },
      { num: 3, title: "Draw a line", desc: "On your turn, draw a line connecting any two dots that don't yet have a line between them. Use your color." },
      { num: 4, title: "Avoid triangles", desc: "Do not complete a triangle where all 3 sides are your color. The player who completes such a triangle loses that round." },
      { num: 5, title: "Win", desc: "Play multiple rounds. First to lose 3 rounds loses the match. Note: by mathematical necessity, every game will end in a triangle — it's just a question of whose." },
    ],
    whatYouNeed: ["Paper", "2 different colored pens or pen + pencil"],
    minPlayers: 2, maxPlayers: 2, duration: "5–15 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "a0000004", name: "Bridges", categoryId: "cat-paper",
    description: "Draw islands and build bridges between them. Create a connected network — but watch out, because your opponent is trying to cut your path.",
    steps: [
      { num: 1, title: "Draw the islands", desc: "Take turns drawing small circles (islands) randomly across the paper — about 10–15 total. Each island can hold a limited number of bridges (write the max inside: 1–4)." },
      { num: 2, title: "Build bridges", desc: "On your turn, draw a line (bridge) between two islands that still have bridge capacity. Bridges must be straight and cannot cross each other." },
      { num: 3, title: "Double bridges", desc: "Two bridges can run parallel between the same pair of islands (counts as 2 toward their capacity)." },
      { num: 4, title: "Connect everything", desc: "The goal is to connect all islands into one fully connected network where you can travel from any island to any other island via bridges." },
      { num: 5, title: "Win", desc: "The player who places the bridge that creates the fully connected network wins. If no valid bridges remain and islands are still isolated, work together to try again." },
    ],
    whatYouNeed: ["Paper", "Pen"],
    minPlayers: 2, maxPlayers: 2, duration: "10–20 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "a0000005", name: "NIM", categoryId: "cat-paper",
    description: "Take objects from piles — but whoever takes the last object loses (or wins, depending on your variant). A deceptively deep strategy game.",
    steps: [
      { num: 1, title: "Set up piles", desc: "Create 3–4 piles of objects (coins, matches, drawn marks on paper). A classic setup: piles of 3, 5, and 7 objects." },
      { num: 2, title: "Take from one pile", desc: "On your turn, take any number of objects from exactly one pile. You must take at least one." },
      { num: 3, title: "Force your opponent", desc: "Manipulate the piles to put your opponent in a losing position. The math behind NIM is real — learn the strategy to dominate." },
      { num: 4, title: "Last object", desc: "The player forced to take the last remaining object loses (Misère NIM). In standard NIM, taking the last object wins." },
      { num: 5, title: "Agree on variant", desc: "Decide before starting: does taking the last object win or lose? Both versions are valid." },
    ],
    whatYouNeed: ["Paper and pen (to draw marks as piles) or coins/matches"],
    minPlayers: 2, maxPlayers: 2, duration: "5–15 min", difficulty: "Medium",
    isDrinking: false, isLibrary: true
  },

  {
    id: "a0000006", name: "SOS", categoryId: "cat-paper",
    description: "Take turns writing S or O in a grid. Form the sequence S-O-S in a line (any direction) to score a point. Most SOS sequences wins.",
    steps: [
      { num: 1, title: "Draw the grid", desc: "Draw a grid — 6×6 or 8×8 works well. All cells start empty." },
      { num: 2, title: "Write S or O", desc: "On your turn, write either an S or an O in any empty cell. Your choice of letter is key." },
      { num: 3, title: "Complete an SOS", desc: "If your letter completes the sequence S-O-S in a straight line (horizontal, vertical, or diagonal), draw a line through it and score 1 point. You go again immediately." },
      { num: 4, title: "Multiple SOS in one move", desc: "If one letter completes multiple SOS sequences, you score for each one." },
      { num: 5, title: "Win", desc: "Play until the grid is full. Player with the most SOS sequences wins." },
    ],
    whatYouNeed: ["Paper", "Pen"],
    minPlayers: 2, maxPlayers: 4, duration: "10–20 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },

  {
    id: "a0000007", name: "Fishbowl", categoryId: "cat-paper",
    description: "One bowl, three rounds. The same clues get harder to describe each round: first Taboo-style, then Charades, then just one word. Teams race to guess the most.",
    steps: [
      { num: 1, title: "Write clues", desc: "Everyone writes 3 words or phrases on separate slips of paper and puts them in a bowl. Anything goes — inside jokes, famous names, objects, phrases." },
      { num: 2, title: "Round 1 — Taboo", desc: "Split into 2 teams. One player draws slips and describes each word without saying it. Their team guesses. 60 seconds per turn. Rotate until the bowl is empty, then count points and refill the bowl." },
      { num: 3, title: "Round 2 — Charades", desc: "Same slips, same teams. This time the describer can only use gestures — no words, no sounds. Team guesses from the action. 60 seconds per turn." },
      { num: 4, title: "Round 3 — One Word", desc: "Same slips again. The describer may say exactly one word as a clue. The team must guess the full phrase from that single word. 60 seconds per turn." },
      { num: 5, title: "Score", desc: "Each correctly guessed clue = 1 point per round. Total across all 3 rounds. Team with the most points wins." },
    ],
    whatYouNeed: ["Paper", "Pens", "A bowl or hat", "Timer"],
    minPlayers: 4, maxPlayers: 99, duration: "30–60 min", difficulty: "Easy",
    isDrinking: false, isLibrary: true
  },
];
