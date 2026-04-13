import SwiftUI

struct NamePickerView: View {
    @State private var players:       [String] = []
    @State private var newName:       String   = ""
    @State private var pickedName:    String?  = nil
    @State private var isPicking:     Bool     = false
    @State private var shuffledOrder: [String] = []
    @State private var showOrder:     Bool     = false
    @FocusState private var focused:  Bool

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    pageHeader
                    addSection
                    if !players.isEmpty {
                        playerListSection
                        pickSection
                        if players.count >= 2 {
                            orderSection
                        }
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Name Picker")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !players.isEmpty {
                    Button {
                        players = []
                        pickedName = nil
                        shuffledOrder = []
                        showOrder = false
                    } label: {
                        Text("Clear")
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
            Text("🎯")
                .font(.system(size: 44))
            Text("Name Picker")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("Add players, then pick a random name.")
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
        }
    }

    // MARK: - Player List

    private var playerListSection: some View {
        VStack(spacing: 0) {
            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)
                .padding(.top, 8)

            ForEach(Array(players.enumerated()), id: \.offset) { idx, name in
                HStack(spacing: 14) {
                    Text(String(format: "%02d", idx + 1))
                        .font(.retroSerif(18))
                        .foregroundStyle(pickedName == name ? Color.retroRust : Color.retroBrown)
                        .frame(width: 30, alignment: .leading)

                    Text(name)
                        .font(.retroSerif(16, weight: pickedName == name ? .semibold : .regular))
                        .foregroundStyle(pickedName == name ? Color.retroRust : Color.retroInk)

                    if pickedName == name {
                        Text("← picked")
                            .font(.retroMono(10))
                            .tracking(1)
                            .foregroundStyle(Color.retroRust)
                    }

                    Spacer()

                    Button {
                        players.remove(at: idx)
                        if pickedName == name { pickedName = nil }
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

    // MARK: - Pick Section

    private var pickSection: some View {
        VStack(spacing: 16) {
            // Result display
            if let name = pickedName {
                VStack(spacing: 6) {
                    Text("PICKED")
                        .font(.retroMono(10))
                        .tracking(2)
                        .foregroundStyle(Color.retroBrown)
                    Text(name)
                        .font(.retroSerif(36, weight: .bold))
                        .foregroundStyle(Color.retroRust)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(Color.retroCard)
                .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                .padding(.horizontal, 20)
            }

            Button {
                pickRandom()
            } label: {
                Text(pickedName == nil ? "Pick a Name →" : "Pick Again →")
                    .font(.retroSerif(17, weight: .bold))
                    .foregroundStyle(Color.retroCream)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(isPicking ? Color.retroBrown.opacity(0.6) : Color.retroInk)
                    .cornerRadius(4)
            }
            .disabled(isPicking || players.isEmpty)
            .padding(.horizontal, 20)
        }
        .padding(.top, 20)
    }

    // MARK: - Order Section

    private var orderSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Random Turn Order")

            Button {
                shuffledOrder = players.shuffled()
                showOrder = true
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "shuffle")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.retroRust)
                    Text("Shuffle Order")
                        .font(.retroSerif(15))
                        .foregroundStyle(Color.retroRust)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .overlay(alignment: .bottom) {
                    Rectangle().fill(Color.retroBorder).frame(height: 1)
                        .padding(.horizontal, 20)
                }
            }
            .buttonStyle(.plain)

            if showOrder && !shuffledOrder.isEmpty {
                Rectangle().fill(Color.retroInk).frame(height: 2)
                    .padding(.horizontal, 20)

                ForEach(Array(shuffledOrder.enumerated()), id: \.offset) { idx, name in
                    HStack(spacing: 14) {
                        Text(String(format: "%02d", idx + 1))
                            .font(.retroSerif(18))
                            .foregroundStyle(Color.retroRust)
                            .frame(width: 30, alignment: .leading)
                        Text(name)
                            .font(.retroSerif(16))
                            .foregroundStyle(Color.retroInk)
                        Spacer()
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
        .padding(.top, 8)
    }

    // MARK: - Actions

    private func addPlayer() {
        let name = newName.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty, !players.contains(name) else { return }
        players.append(name)
        newName = ""
    }

    private func pickRandom() {
        guard !players.isEmpty else { return }
        isPicking = true
        // Quick flash through names before settling
        var flashes = 0
        let total = Int.random(in: 8...14)
        Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { t in
            pickedName = players.randomElement()
            flashes += 1
            if flashes >= total {
                t.invalidate()
                pickedName = players.randomElement()
                isPicking = false
            }
        }
    }
}

#Preview {
    NavigationStack { NamePickerView() }
}
