import SwiftUI

struct DrinkDistributorView: View {
    @State private var players:  [String]      = []
    @State private var log:      [DrinkLogEntry] = []
    @State private var newName:  String        = ""
    @State private var drinks:   Int           = 1
    @FocusState private var focused: Bool

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    pageHeader
                    addPlayerSection
                    if !players.isEmpty {
                        drinkCountSection
                        assignSection
                    }
                    if !log.isEmpty { logSection }
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Drink Distributor")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !log.isEmpty {
                    Button {
                        log = []
                    } label: {
                        Text("Clear Log")
                            .font(.retroMono(12))
                            .foregroundStyle(Color.retroBrown)
                    }
                }
            }
        }
    }

    // MARK: - Page Header

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("🍺")
                .font(.system(size: 44))
            Text("Drink Distributor")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("Assign drinks and keep a running log.")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    // MARK: - Add Player

    private var addPlayerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            RetroSectionHeader(title: "Players")

            HStack(spacing: 10) {
                TextField("Add a player", text: $newName)
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
                    .onSubmit { addPlayer() }

                Button(action: addPlayer) {
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

            if !players.isEmpty {
                Rectangle().fill(Color.retroInk).frame(height: 2)
                    .padding(.horizontal, 20)
                    .padding(.top, 4)

                ForEach(Array(players.enumerated()), id: \.offset) { idx, name in
                    HStack(spacing: 14) {
                        Text(String(format: "%02d", idx + 1))
                            .font(.retroSerif(16))
                            .foregroundStyle(Color.retroRust)
                            .frame(width: 30, alignment: .leading)
                        Text(name)
                            .font(.retroSerif(15))
                            .foregroundStyle(Color.retroInk)
                        Spacer()
                        Text("\(totalDrinksFor(name)) 🍺")
                            .font(.retroMono(11))
                            .foregroundStyle(Color.retroBrown)
                        Button {
                            players.removeAll { $0 == name }
                        } label: {
                            Image(systemName: "minus.circle")
                                .font(.system(size: 15))
                                .foregroundStyle(Color.retroBorder)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .overlay(alignment: .bottom) {
                        Rectangle().fill(Color.retroBorder).frame(height: 1)
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
    }

    // MARK: - Drink Count

    private var drinkCountSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Drinks to assign")

            HStack {
                Text("HOW MANY DRINKS?")
                    .font(.retroMono(10))
                    .tracking(1.5)
                    .foregroundStyle(Color.retroBrown)
                Spacer()
                HStack(spacing: 0) {
                    Button {
                        if drinks > 1 { drinks -= 1 }
                    } label: {
                        Text("−")
                            .font(.retroSerif(20, weight: .semibold))
                            .foregroundStyle(drinks > 1 ? Color.retroInk : Color.retroBorder)
                            .frame(width: 44, height: 44)
                            .background(Color.retroCard)
                            .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    }
                    .disabled(drinks <= 1)

                    Text("\(drinks)")
                        .font(.retroMono(18))
                        .foregroundStyle(Color.retroInk)
                        .frame(width: 44, height: 44)
                        .contentTransition(.numericText())
                        .overlay(
                            Rectangle()
                                .stroke(Color.retroBorder, lineWidth: 1)
                                .padding(.horizontal, -1)
                        )

                    Button {
                        if drinks < 20 { drinks += 1 }
                    } label: {
                        Text("+")
                            .font(.retroSerif(20, weight: .semibold))
                            .foregroundStyle(drinks < 20 ? Color.retroRust : Color.retroBorder)
                            .frame(width: 44, height: 44)
                            .background(Color.retroCard)
                            .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    }
                    .disabled(drinks >= 20)
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

    // MARK: - Assign

    private var assignSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Tap to assign \(drinks) drink\(drinks == 1 ? "" : "s")")

            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)

            ForEach(Array(players.enumerated()), id: \.offset) { idx, name in
                Button {
                    log.append(DrinkLogEntry(player: name, drinks: drinks))
                } label: {
                    HStack(spacing: 14) {
                        Text(String(format: "%02d", idx + 1))
                            .font(.retroSerif(18))
                            .foregroundStyle(Color.retroRust)
                            .frame(width: 30, alignment: .leading)
                        Text(name)
                            .font(.retroSerif(17, weight: .semibold))
                            .foregroundStyle(Color.retroInk)
                        Spacer()
                        Text("Give \(drinks) 🍺")
                            .font(.retroMono(11))
                            .tracking(0.5)
                            .foregroundStyle(Color.retroBrown)
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
    }

    // MARK: - Log

    private var logSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Log — \(log.reduce(0) { $0 + $1.drinks }) total drinks")

            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)

            ForEach(Array(log.reversed().enumerated()), id: \.element.id) { idx, entry in
                HStack(spacing: 14) {
                    Text(String(format: "%02d", log.count - idx))
                        .font(.retroSerif(16))
                        .foregroundStyle(Color.retroBrown)
                        .frame(width: 30, alignment: .leading)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(entry.player)
                            .font(.retroSerif(15, weight: .semibold))
                            .foregroundStyle(Color.retroInk)
                        Text(entry.timestamp, style: .time)
                            .font(.retroMono(10))
                            .foregroundStyle(Color.retroBrown)
                    }
                    Spacer()
                    Text("+\(entry.drinks) 🍺")
                        .font(.retroSerif(16, weight: .semibold))
                        .foregroundStyle(Color.retroRust)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Color.retroBorder).frame(height: 1)
                        .padding(.horizontal, 20)
                }
            }
        }
        .padding(.top, 8)
    }

    // MARK: - Helpers

    private func addPlayer() {
        let name = newName.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty, !players.contains(name) else { return }
        players.append(name)
        newName = ""
    }

    private func totalDrinksFor(_ player: String) -> Int {
        log.filter { $0.player == player }.reduce(0) { $0 + $1.drinks }
    }
}

struct DrinkLogEntry: Identifiable {
    let id        = UUID()
    let player:    String
    let drinks:    Int
    let timestamp: Date = .now
}

#Preview {
    NavigationStack { DrinkDistributorView() }
}
