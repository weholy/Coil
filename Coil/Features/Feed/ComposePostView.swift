import SwiftUI

struct ComposePostView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""

    var body: some View {
        NavigationStack {
            HStack(alignment: .top, spacing: 10) {
                AvatarView(user: CurrentUser.placeholder, size: Metrics.avatarMedium)

                TextField("Что нового?", text: $text, axis: .vertical)
                    .font(Typography.body)
                    .lineLimit(4...10)

                Spacer(minLength: 0)
            }
            .padding(Metrics.screenPadding)
            .background(Palette.canvas)
            .navigationTitle("Новый пост")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Опубликовать") { dismiss() }
                        .fontWeight(.semibold)
                        .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}
