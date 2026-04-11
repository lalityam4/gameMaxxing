import SwiftUI

// MARK: - Colors
extension Color {
    static let retroCream  = Color(red: 250/255, green: 244/255, blue: 234/255)
    static let retroInk    = Color(red: 28/255,  green: 18/255,  blue: 8/255)
    static let retroRust   = Color(red: 192/255, green: 75/255,  blue: 26/255)
    static let retroBrown  = Color(red: 107/255, green: 80/255,  blue: 64/255)
    static let retroCard   = Color(red: 240/255, green: 228/255, blue: 208/255)
    static let retroBorder = Color(red: 212/255, green: 185/255, blue: 154/255)
}

// MARK: - Fonts
extension Font {
    static func retroSerif(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .serif)
    }
    static func retroMono(_ size: CGFloat) -> Font {
        .system(size: size, weight: .regular, design: .monospaced)
    }
}

// MARK: - Reusable Views

struct RetroSectionHeader: View {
    let title: String
    var body: some View {
        HStack(spacing: 12) {
            Text(title.uppercased())
                .font(.retroMono(10))
                .tracking(2)
                .foregroundStyle(Color.retroBrown)
            Rectangle()
                .fill(Color.retroBorder)
                .frame(height: 1)
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .padding(.bottom, 8)
    }
}

struct RetroInfoChip: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label.uppercased())
                .font(.retroMono(9))
                .tracking(1.5)
                .foregroundStyle(Color.retroBrown)
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.retroRust)
                Text(value)
                    .font(.retroSerif(14, weight: .semibold))
                    .foregroundStyle(Color.retroInk)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(Color.retroCard)
        .overlay(
            Rectangle()
                .stroke(Color.retroBorder, lineWidth: 1)
        )
    }
}

struct RetroDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.retroBorder)
            .frame(height: 1)
            .padding(.horizontal, 20)
    }
}
