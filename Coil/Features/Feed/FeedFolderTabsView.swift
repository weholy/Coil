import SwiftUI

struct FeedFolderTabsView: View {
    let folders: [FeedFolder]
    @Binding var selectedFolderID: Int
    var onAddFolder: () -> Void = {}

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 22) {
                ForEach(folders) { folder in
                    let isSelected = selectedFolderID == folder.id
                    Button {
                        selectedFolderID = folder.id
                    } label: {
                        Text(folder.name)
                            .font(isSelected ? Typography.headline : Typography.subheadline)
                            .foregroundStyle(isSelected ? Palette.textPrimary : Palette.textSecondary)
                    }
                    .buttonStyle(.plain)
                }

                Button(action: onAddFolder) {
                    Image(systemName: "plus")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Palette.textSecondary)
                        .frame(width: 28, height: 28)
                        .glassCircle()
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, Metrics.screenPadding)
        }
    }
}
