import SwiftUI
import PhotosUI

private struct IdentifiableUUID: Identifiable {
    let id: UUID
}

// Curated SF symbols users can pick for a step
private let symbolOptions: [String] = [
    "1.circle.fill","2.circle.fill","3.circle.fill","4.circle.fill","5.circle.fill",
    "6.circle.fill","7.circle.fill","8.circle.fill","9.circle.fill","10.circle.fill",
    "hand.raised.fill","hand.point.right.fill","person.2.fill","person.3.fill",
    "arrow.clockwise","shuffle","star.fill","trophy.fill",
    "checkmark.circle.fill","xmark.circle.fill","clock.fill","eye.fill",
    "questionmark.circle.fill","rectangle.stack.fill","die.face.5.fill",
    "chart.bar.fill","speaker.wave.2.fill","pencil.circle.fill",
    "arrowshape.turn.up.right.fill","light.max","bolt.fill","flag.fill"
]

struct AddEditGameView: View {
    @Environment(GameStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    // Pre-fill category if coming from CategoryView
    var categoryId: UUID? = nil
    // Pass existing game to edit
    var existingGame: Game? = nil

    // Form state
    @State private var name = ""
    @State private var selectedCategoryId: UUID = GameLibrary.categories[0].id
    @State private var description = ""
    @State private var minPlayers = 2
    @State private var maxPlayers = 8
    @State private var unlimitedMax = false
    @State private var duration = ""
    @State private var difficulty = "Easy"
    @State private var whatYouNeed: [String] = [""]
    @State private var steps: [EditableStep] = [EditableStep(stepNumber: 1)]

    // Symbol picker state
    @State private var pickingSymbolForStep: IdentifiableUUID? = nil

    private let difficulties = ["Easy", "Medium", "Hard"]

    var isEditing: Bool { existingGame != nil }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.retroCream.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        basicInfoSection
                        RetroDivider().padding(.vertical, 8)
                        playersSection
                        RetroDivider().padding(.vertical, 8)
                        whatYouNeedSection
                        RetroDivider().padding(.vertical, 8)
                        stepsSection
                    }
                    .padding(.bottom, 80)
                }
                // Save button pinned at bottom
                VStack {
                    Spacer()
                    saveButton
                }
            }
            .navigationTitle(isEditing ? "Edit Game" : "New Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.retroCream, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(Color.retroBrown)
                }
            }
            .onAppear { loadExistingGame() }
            .sheet(item: $pickingSymbolForStep) { wrapper in
                SymbolPickerSheet(stepId: wrapper.id, steps: $steps)
            }
        }
    }

    // MARK: - Basic Info
    private var basicInfoSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Game Info")

            RetroField(label: "NAME", placeholder: "e.g. Uno Attack") {
                TextField("", text: $name)
                    .font(.retroSerif(17))
                    .foregroundStyle(Color.retroInk)
            }

            RetroField(label: "CATEGORY") {
                Picker("", selection: $selectedCategoryId) {
                    ForEach(store.allCategories) { cat in
                        Text(cat.emoji + " " + cat.name).tag(cat.id)
                    }
                }
                .pickerStyle(.menu)
                .tint(Color.retroInk)
            }

            RetroField(label: "DESCRIPTION", placeholder: "What's this game about?") {
                TextEditor(text: $description)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.retroInk)
                    .frame(minHeight: 80)
                    .scrollContentBackground(.hidden)
            }

            RetroField(label: "DURATION", placeholder: "e.g. 15–30 min") {
                TextField("", text: $duration)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.retroInk)
            }

            RetroField(label: "DIFFICULTY") {
                Picker("", selection: $difficulty) {
                    ForEach(difficulties, id: \.self) { Text($0).tag($0) }
                }
                .pickerStyle(.segmented)
            }
        }
    }

    // MARK: - Players
    private var playersSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "Players")
            HStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("MIN").font(.retroMono(10)).tracking(2).foregroundStyle(Color.retroBrown)
                    Stepper("\(minPlayers)", value: $minPlayers, in: 1...99)
                        .font(.retroSerif(16))
                        .foregroundStyle(Color.retroInk)
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text("MAX").font(.retroMono(10)).tracking(2).foregroundStyle(Color.retroBrown)
                    if unlimitedMax {
                        Text("No limit").font(.retroSerif(16)).foregroundStyle(Color.retroBrown)
                    } else {
                        Stepper("\(maxPlayers)", value: $maxPlayers, in: minPlayers...99)
                            .font(.retroSerif(16))
                            .foregroundStyle(Color.retroInk)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)

            Toggle(isOn: $unlimitedMax) {
                Text("No upper limit on players")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.retroBrown)
            }
            .tint(Color.retroRust)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
    }

    // MARK: - What You Need
    private var whatYouNeedSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "What You Need")
            VStack(spacing: 8) {
                ForEach(whatYouNeed.indices, id: \.self) { i in
                    HStack(spacing: 8) {
                        Text("—")
                            .font(.retroSerif(14))
                            .foregroundStyle(Color.retroRust)
                        TextField("e.g. Standard deck of cards", text: $whatYouNeed[i])
                            .font(.system(size: 14))
                            .foregroundStyle(Color.retroInk)
                        if whatYouNeed.count > 1 {
                            Button {
                                whatYouNeed.remove(at: i)
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundStyle(Color.retroBorder)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                Button {
                    whatYouNeed.append("")
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "plus.circle")
                        Text("Add item")
                    }
                    .font(.system(size: 13))
                    .foregroundStyle(Color.retroRust)
                }
                .padding(.horizontal, 20)
                .padding(.top, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 16)
        }
    }

    // MARK: - Steps
    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            RetroSectionHeader(title: "How to Play")
            VStack(spacing: 0) {
                ForEach($steps) { $step in
                    EditableStepRow(
                        step: $step,
                        onDelete: { steps.removeAll { $0.id == step.id }; renumber() },
                        onPickSymbol: { pickingSymbolForStep = IdentifiableUUID(id: step.id) }
                    )
                    RetroDivider()
                }
                Button {
                    steps.append(EditableStep(stepNumber: steps.count + 1))
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle")
                        Text("Add step")
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(Color.retroRust)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    // MARK: - Save Button
    private var saveButton: some View {
        Button {
            saveGame()
            dismiss()
        } label: {
            Text(isEditing ? "Save Changes" : "Add Game")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.retroCream)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(name.trimmingCharacters(in: .whitespaces).isEmpty ? Color.retroBorder : Color.retroInk)
        }
        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
        .background(Color.retroCream)
    }

    // MARK: - Helpers
    private func loadExistingGame() {
        if let cid = categoryId { selectedCategoryId = cid }
        guard let game = existingGame else { return }
        name = game.name
        selectedCategoryId = game.categoryId
        description = game.description
        minPlayers = game.minPlayers
        unlimitedMax = game.maxPlayers >= 99
        maxPlayers = unlimitedMax ? 8 : game.maxPlayers
        duration = game.duration
        difficulty = game.difficulty
        whatYouNeed = game.whatYouNeed.isEmpty ? [""] : game.whatYouNeed
        steps = game.steps.map { EditableStep(from: $0) }
    }

    private func renumber() {
        for i in steps.indices { steps[i].stepNumber = i + 1 }
    }

    private func saveGame() {
        let resolvedMax = unlimitedMax ? 99 : maxPlayers
        let gameSteps = steps
            .filter { !$0.title.trimmingCharacters(in: .whitespaces).isEmpty }
            .enumerated()
            .map { idx, s in
                GameStep(
                    id: s.id,
                    stepNumber: idx + 1,
                    title: s.title.trimmingCharacters(in: .whitespaces),
                    description: s.description.trimmingCharacters(in: .whitespaces),
                    sfSymbol: s.sfSymbol,
                    customImageData: s.customImageData
                )
            }
        let needs = whatYouNeed.map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }

        let game = Game(
            id: existingGame?.id ?? UUID(),
            name: name.trimmingCharacters(in: .whitespaces),
            categoryId: selectedCategoryId,
            description: description.trimmingCharacters(in: .whitespaces),
            steps: gameSteps,
            whatYouNeed: needs,
            minPlayers: minPlayers,
            maxPlayers: resolvedMax,
            duration: duration.trimmingCharacters(in: .whitespaces),
            difficulty: difficulty,
            isLibraryGame: false
        )

        if isEditing { store.updateCustomGame(game) } else { store.addCustomGame(game) }
    }
}

// MARK: - Editable Step Model (local to this view)

struct EditableStep: Identifiable {
    let id: UUID
    var stepNumber: Int
    var title: String = ""
    var description: String = ""
    var sfSymbol: String
    var customImageData: Data? = nil

    init(stepNumber: Int) {
        self.id = UUID()
        self.stepNumber = stepNumber
        self.sfSymbol = "\(min(stepNumber, 50)).circle.fill"
    }

    init(from step: GameStep) {
        self.id = step.id
        self.stepNumber = step.stepNumber
        self.title = step.title
        self.description = step.description
        self.sfSymbol = step.sfSymbol
        self.customImageData = step.customImageData
    }
}

// MARK: - Editable Step Row

private struct EditableStepRow: View {
    @Binding var step: EditableStep
    var onDelete: () -> Void
    var onPickSymbol: () -> Void

    @State private var photoItem: PhotosPickerItem? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                // Symbol picker button
                Button(action: onPickSymbol) {
                    ZStack {
                        Rectangle()
                            .fill(Color.retroCard)
                            .frame(width: 44, height: 44)
                            .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                        Image(systemName: step.sfSymbol)
                            .font(.system(size: 20))
                            .foregroundStyle(Color.retroRust)
                    }
                }
                .buttonStyle(.plain)

                VStack(alignment: .leading, spacing: 4) {
                    Text("STEP \(step.stepNumber)")
                        .font(.retroMono(9))
                        .tracking(2)
                        .foregroundStyle(Color.retroBrown)
                    TextField("Step title", text: $step.title)
                        .font(.retroSerif(15, weight: .semibold))
                        .foregroundStyle(Color.retroInk)
                }

                Spacer()

                Button(action: onDelete) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundStyle(Color.retroBorder)
                        .font(.system(size: 20))
                }
                .buttonStyle(.plain)
            }

            TextEditor(text: $step.description)
                .font(.system(size: 14))
                .foregroundStyle(Color.retroInk)
                .frame(minHeight: 60)
                .scrollContentBackground(.hidden)
                .padding(.leading, 56)

            // Image area
            HStack(spacing: 10) {
                Spacer().frame(width: 56)
                if let data = step.customImageData, let uiImage = UIImage(data: data) {
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 140)
                            .cornerRadius(4)
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.retroBorder, lineWidth: 1))
                        Button {
                            step.customImageData = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.white)
                                .background(Circle().fill(Color.black.opacity(0.5)))
                                .padding(4)
                        }
                    }
                } else {
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        HStack(spacing: 6) {
                            Image(systemName: "photo.badge.plus")
                            Text("Add image")
                        }
                        .font(.system(size: 13))
                        .foregroundStyle(Color.retroRust)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .overlay(Rectangle().stroke(Color.retroBorder, lineWidth: 1))
                    }
                }
            }
            .onChange(of: photoItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        step.customImageData = data
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

// MARK: - Symbol Picker Sheet

private struct SymbolPickerSheet: View {
    let stepId: UUID
    @Binding var steps: [EditableStep]
    @Environment(\.dismiss) private var dismiss

    private let columns = Array(repeating: GridItem(.flexible()), count: 6)

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Pick an icon")
                        .font(.retroSerif(20, weight: .bold))
                        .foregroundStyle(Color.retroInk)
                    Spacer()
                    Button("Done") { dismiss() }
                        .foregroundStyle(Color.retroRust)
                }
                .padding(20)

                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(symbolOptions, id: \.self) { symbol in
                        Button {
                            if let idx = steps.firstIndex(where: { $0.id == stepId }) {
                                steps[idx].sfSymbol = symbol
                            }
                            dismiss()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill(isSelected(symbol) ? Color.retroCard : Color.clear)
                                    .frame(width: 48, height: 48)
                                    .overlay(Rectangle().stroke(isSelected(symbol) ? Color.retroRust : Color.retroBorder, lineWidth: 1))
                                Image(systemName: symbol)
                                    .font(.system(size: 22))
                                    .foregroundStyle(isSelected(symbol) ? Color.retroRust : Color.retroBrown)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            }
        }
        .presentationDetents([.medium, .large])
    }

    private func isSelected(_ symbol: String) -> Bool {
        steps.first(where: { $0.id == stepId })?.sfSymbol == symbol
    }
}

// MARK: - Retro Form Field Wrapper

private struct RetroField<Content: View>: View {
    let label: String
    var placeholder: String = ""
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.retroMono(10))
                .tracking(2)
                .foregroundStyle(Color.retroBrown)
            content()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.retroBorder).frame(height: 1)
                .padding(.horizontal, 20)
        }
    }
}

// Make EditableStep conform to Identifiable for .sheet(item:)
extension EditableStep: Hashable {
    static func == (lhs: EditableStep, rhs: EditableStep) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

#Preview {
    AddEditGameView()
        .environment(GameStore())
}
