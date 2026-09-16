import SwiftUI

struct FeedFolderTabsView: View {
    let folders: [FeedFolder]
    @Binding var selectedFolderID: Int
    var onAddFolder: () -> Void = {}

    static let forYouID = 0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                pill(id: Self.forYouID, name: "Для вас", icon: "sparkles")

                ForEach(folders) { folder in
                    pill(id: folder.id, name: folder.name, icon: folder.icon)
                }

                Button(action: onAddFolder) {
                    Image(systemName: "plus")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Palette.textSecondary)
                        .frame(width: 32, height: 32)
                        .glassCircle()
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, Metrics.screenPadding)
        }
    }

    private func pill(id: Int, name: String, icon: String) -> some View {
        let isSelected = selectedFolderID == id
        return Button {
            selectedFolderID = id
        } label: {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .semibold))
                Text(name)
                    .font(Typography.subheadline)
            }
            .foregroundStyle(isSelected ? Color.white : Palette.textPrimary)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background {
                Capsule().fill(isSelected ? Palette.accent : Palette.surface)
            }
            .overlay {
                if !isSelected {
                    Capsule().stroke(Palette.hairline, lineWidth: 1)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
