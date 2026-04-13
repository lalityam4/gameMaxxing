import SwiftUI

// MARK: - Model

struct MatchedPair: Identifiable {
    let id = UUID()
    let name: String
    let assignedTo: String
    var isFlipped: Bool = false
}

// MARK: - View

struct RandomMatchingView: View {
    enum Phase { case setup, active }

    @State private var names: [String] = []
    @State private var newName: String = ""
    @State private var pairs: [MatchedPair] = []
    @State private var phase: Phase = .setup
    @FocusState private var nameFieldFocused: Bool

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if phase == .setup {
                        setupPhase
                    } else {
                        activePhase
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Matching")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
    }

    // MARK: - Setup Phase

    private var setupPhase: some View {
        VStack(alignment: .leading, spacing: 0) {
            pageHeader
            addSection
            if !names.isEmpty {
                nameListSection
            }
            generateButton
        }
    }

    private var pageHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("🔀")
                .font(.system(size: 44))
            Text("Randomized Matching")
                .font(.retroSerif(30, weight: .bold))
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
            Text("Each person is secretly assigned another.")
                .font(.retroMono(11))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    private var addSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            RetroSectionHeader(title: "Names")

            HStack(spacing: 10) {
                TextField("Enter a name", text: $newName)
                    .font(.retroSerif(16))
                    .foregroundStyle(Color.retroInk)
                    .tint(Color.retroRust)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 11)
                    .background(Color.retroCard)
                    .overlay(Rectangle().stroke(
                        nameFieldFocused ? Color.retroRust : Color.retroBorder,
                        lineWidth: 1
                    ))
                    .focused($nameFieldFocused)
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

    private var nameListSection: some View {
        VStack(spacing: 0) {
            Rectangle().fill(Color.retroInk).frame(height: 2)
                .padding(.horizontal, 20)
                .padding(.top, 8)

            ForEach(Array(names.enumerated()), id: \.offset) { idx, name in
                HStack(spacing: 14) {
                    Text(String(format: "%02d", idx + 1))
                        .font(.retroSerif(18))
                        .foregroundStyle(Color.retroBrown)
                        .frame(width: 30, alignment: .leading)

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

    private var generateButton: some View {
        Button {
            generateMatches()
        } label: {
            Text("Generate Matches →")
                .font(.retroSerif(17, weight: .bold))
                .foregroundStyle(Color.retroCream)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(names.count < 2 ? Color.retroBrown.opacity(0.4) : Color.retroInk)
                .cornerRadius(4)
        }
        .disabled(names.count < 2)
        .padding(.horizontal, 20)
        .padding(.top, 24)
    }

    // MARK: - Active Phase

    private var activePhase: some View {
        VStack(alignment: .leading, spacing: 0) {
            activeHeader
            cardGrid
            actionButtons
            startOverButton
        }
    }

    private var activeHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(pairs.count) MATCHES GENERATED")
                .font(.retroMono(13))
                .tracking(1.5)
                .foregroundStyle(Color.retroInk)
            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }

    private var cardGrid: some View {
        LazyVGrid(
            columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)],
            spacing: 12
        ) {
            ForEach(Array(pairs.enumerated()), id: \.element.id) { index, pair in
                flipCard(pair: pair, index: index)
            }
        }
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    private func flipCard(pair: MatchedPair, index: Int) -> some View {
        ZStack {
            // Front: rotates 0 → 180 (disappears at 90°)
            frontCardFace(name: pair.name)
                .rotation3DEffect(.degrees(pair.isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .opacity(pair.isFlipped ? 0 : 1)

            // Back: starts at 180 (hidden), rotates to 360/0 (visible, text correct)
            backCardFace(assignedTo: pair.assignedTo)
                .rotation3DEffect(.degrees(pair.isFlipped ? 360 : 180), axis: (x: 0, y: 1, z: 0))
                .opacity(pair.isFlipped ? 1 : 0)
        }
        .frame(width: 160, height: 130)
        .animation(.easeInOut(duration: 0.4), value: pair.isFlipped)
        .onTapGesture {
            pairs[index].isFlipped.toggle()
        }
    }

    private func frontCardFace(name: String) -> some View {
        ZStack {
            Color.retroCard
            VStack(spacing: 8) {
                Text(name)
                    .font(.retroSerif(16, weight: .semibold))
                    .foregroundStyle(Color.retroInk)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                Text("TAP TO REVEAL")
                    .font(.retroMono(9))
                    .tracking(1.5)
                    .foregroundStyle(Color.retroBrown)
            }
            .padding(12)
        }
        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
    }

    private func backCardFace(assignedTo: String) -> some View {
        ZStack {
            Color.retroInk
            VStack(spacing: 8) {
                Text("ASSIGNED TO")
                    .font(.retroMono(9))
                    .tracking(1.5)
                    .foregroundStyle(Color.retroCard.opacity(0.7))
                Text(assignedTo)
                    .font(.retroSerif(18, weight: .bold))
                    .foregroundStyle(Color.retroCream)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                Rectangle()
                    .fill(Color.retroRust)
                    .frame(width: 24, height: 2)
            }
            .padding(12)
        }
        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
    }

    private var actionButtons: some View {
        HStack(spacing: 12) {
            // Flip All
            Button {
                let allFlipped = pairs.allSatisfy { $0.isFlipped }
                for i in pairs.indices {
                    pairs[i].isFlipped = !allFlipped
                }
            } label: {
                Text(pairs.allSatisfy { $0.isFlipped } ? "Hide All" : "Flip All")
                    .font(.retroSerif(15, weight: .semibold))
                    .foregroundStyle(Color.retroInk)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Color.retroCard)
                    .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    .cornerRadius(4)
            }

            // Re-shuffle
            Button {
                generateMatches()
            } label: {
                Text("Re-shuffle")
                    .font(.retroSerif(15, weight: .semibold))
                    .foregroundStyle(Color.retroCream)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Color.retroInk)
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }

    private var startOverButton: some View {
        Button {
            withAnimation {
                pairs = []
                phase = .setup
            }
        } label: {
            Text("Start Over")
                .font(.retroMono(12))
                .tracking(0.5)
                .foregroundStyle(Color.retroBrown)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
    }

    // MARK: - Logic

    private func addName() {
        let name = newName.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty, !names.contains(name) else { return }
        names.append(name)
        newName = ""
    }

    private func makeDerangement(of names: [String]) -> [String] {
        guard names.count > 1 else { return names }
        var result = names.shuffled()
        while zip(names, result).contains(where: { $0 == $1 }) {
            result.shuffle()
        }
        return result
    }

    private func generateMatches() {
        let assigned = makeDerangement(of: names)
        pairs = zip(names, assigned).map { MatchedPair(name: $0, assignedTo: $1) }
        phase = .active
    }
}

#Preview {
    NavigationStack { RandomMatchingView() }
}
