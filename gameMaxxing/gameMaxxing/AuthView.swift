import SwiftUI

struct AuthView: View {
    @Environment(GameStore.self) private var store
    @State private var name: String = ""
    @State private var shake: Bool = false
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            Color.retroCream.ignoresSafeArea()

            VStack(spacing: 0) {

                Spacer()

                // — Title block —
                VStack(spacing: 10) {
                    Text("🎲")
                        .font(.system(size: 52))

                    Text("GameMaxxing")
                        .font(.retroSerif(38, weight: .bold))
                        .foregroundStyle(Color.retroInk)

                    Rectangle()
                        .fill(Color.retroRust)
                        .frame(width: 48, height: 2)

                    Text("Your personal collection of\ngroup games — documented.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.retroBrown)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }

                Spacer()

                // — Name entry —
                VStack(alignment: .leading, spacing: 8) {
                    Text("WHAT SHOULD WE CALL YOU?")
                        .font(.retroMono(10))
                        .tracking(2)
                        .foregroundStyle(Color.retroBrown)

                    TextField("Your name", text: $name)
                        .font(.retroSerif(20, weight: .semibold))
                        .foregroundStyle(Color.retroInk)
                        .tint(Color.retroRust)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(Color.retroCard)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(isFocused ? Color.retroRust : Color.retroBorder, lineWidth: 1.5)
                        )
                        .cornerRadius(4)
                        .focused($isFocused)
                        .submitLabel(.go)
                        .onSubmit { attemptSignIn() }
                        .modifier(ShakeEffect(trigger: shake))
                }
                .padding(.horizontal, 36)

                // — CTA button —
                Button(action: attemptSignIn) {
                    Text("Let's Play →")
                        .font(.retroSerif(17, weight: .bold))
                        .foregroundStyle(Color.retroCream)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(name.trimmingCharacters(in: .whitespaces).isEmpty
                                    ? Color.retroBrown.opacity(0.4)
                                    : Color.retroInk)
                        .cornerRadius(4)
                }
                .padding(.horizontal, 36)
                .padding(.top, 16)
                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)

                // — Fine print —
                Text("Your data stays on this device. No account needed.")
                    .font(.retroMono(10))
                    .tracking(1)
                    .foregroundStyle(Color.retroBorder)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                    .padding(.bottom, 52)
                    .padding(.horizontal, 36)
            }
        }
        .onTapGesture { isFocused = false }
    }

    private func attemptSignIn() {
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            triggerShake()
            return
        }
        store.signInLocally(name: trimmed)
    }

    private func triggerShake() {
        withAnimation(.default) { shake = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { shake = false }
    }
}

// MARK: - Shake animation modifier
struct ShakeEffect: ViewModifier {
    var trigger: Bool

    func body(content: Content) -> some View {
        content
            .offset(x: trigger ? -8 : 0)
            .animation(
                trigger
                    ? .linear(duration: 0.07).repeatCount(4, autoreverses: true)
                    : .default,
                value: trigger
            )
    }
}

#Preview {
    AuthView()
        .environment(GameStore())
}
