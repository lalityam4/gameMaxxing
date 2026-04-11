import SwiftUI

struct GameDetailView: View {
    @Environment(GameStore.self) private var store
    let game: Game

    @State private var showingEdit = false
    @State private var showingDelete = false
    @Environment(\.dismiss) private var dismiss

    private var category: GameCategory? {
        store.category(for: game)
    }

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    gameHeader
                    infoChips
                    RetroDivider().padding(.top, 20)
                    whatYouNeedSection
                    RetroDivider()
                    howToPlaySection
                }
                .padding(.bottom, 60)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.retroCream, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !game.isLibraryGame {
                    Menu {
                        Button { showingEdit = true } label: {
                            Label("Edit Game", systemImage: "pencil")
                        }
                        Button("Delete Game", role: .destructive) {
                            showingDelete = true
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundStyle(Color.retroBrown)
                    }
                } else {
                    Button(role: .destructive) {
                        store.hideLibraryGame(game)
                        dismiss()
                    } label: {
                        Image(systemName: "eye.slash")
                            .foregroundStyle(Color.retroBrown)
                    }
                }
            }
        }
        .sheet(isPresented: $showingEdit) {
            AddEditGameView(existingGame: game)
        }
        .confirmationDialog("Delete \"\(game.name)\"?", isPresented: $showingDelete, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                store.deleteCustomGame(game)
                dismiss()
            }
        }
    }

    // MARK: - Header
    private var gameHeader: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let cat = category {
                Text((cat.emoji + " " + cat.name).uppercased())
                    .font(.retroMono(10))
                    .tracking(2)
                    .foregroundStyle(Color.retroRust)
            }
            Text(game.name)
                .font(.retroSerif(32, weight: .bold))
                .foregroundStyle(Color.retroInk)
                .fixedSize(horizontal: false, vertical: true)

            Rectangle()
                .fill(Color.retroRust)
                .frame(width: 40, height: 2)
                .padding(.top, 2)

            Text(game.description)
                .font(.system(size: 15))
                .foregroundStyle(Color.retroBrown)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 20)
    }

    // MARK: - Info Chips
    private var infoChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                RetroInfoChip(icon: "person.2", label: "Players", value: game.playersDisplay)
                RetroInfoChip(icon: "clock", label: "Duration", value: game.duration)
                RetroInfoChip(icon: "chart.bar", label: "Difficulty", value: game.difficulty)
            }
            .padding(.horizontal, 20)
        }
    }

    // MARK: - What You Need
    private var whatYouNeedSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "What you need")
            VStack(alignment: .leading, spacing: 10) {
                if game.whatYouNeed.isEmpty {
                    Text("Nothing — just people.")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.retroBrown)
                } else {
                    ForEach(game.whatYouNeed, id: \.self) { item in
                        HStack(alignment: .top, spacing: 10) {
                            Text("—")
                                .font(.retroSerif(14))
                                .foregroundStyle(Color.retroRust)
                            Text(item)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.retroInk)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }

    // MARK: - How to Play
    private var howToPlaySection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "How to play")
            VStack(alignment: .leading, spacing: 0) {
                ForEach(game.steps) { step in
                    StepRow(step: step)
                    if step.id != game.steps.last?.id {
                        RetroDivider()
                    }
                }
                if game.steps.isEmpty {
                    Text("No steps documented yet.")
                        .font(.retroMono(12))
                        .foregroundStyle(Color.retroBrown)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                }
            }
        }
    }
}

// MARK: - Step Row

private struct StepRow: View {
    let step: GameStep

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 12) {
                // Auto SF Symbol
                ZStack {
                    Rectangle()
                        .fill(Color.retroCard)
                        .frame(width: 44, height: 44)
                        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    Image(systemName: step.sfSymbol)
                        .font(.system(size: 20))
                        .foregroundStyle(Color.retroRust)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Step \(step.stepNumber)")
                        .font(.retroMono(10))
                        .tracking(1.5)
                        .foregroundStyle(Color.retroBrown)
                    Text(step.title)
                        .font(.retroSerif(16, weight: .semibold))
                        .foregroundStyle(Color.retroInk)
                }
            }

            Text(step.description)
                .font(.system(size: 14))
                .foregroundStyle(Color.retroInk)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading, 56)

            // Custom image if added
            if let data = step.customImageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 220)
                    .cornerRadius(4)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.retroBorder, lineWidth: 1))
                    .padding(.leading, 56)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
    }
}

#Preview {
    NavigationStack {
        GameDetailView(game: GameLibrary.games[0])
            .environment(GameStore())
    }
}
