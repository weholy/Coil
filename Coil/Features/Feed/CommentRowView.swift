import SwiftUI

struct CommentRowView: View {
    let comment: Comment
    var onReply: () -> Void = {}

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AvatarView(user: comment.author, size: Metrics.avatarSmall)

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    Text(comment.author.displayName)
                        .font(Typography.subheadline)
                        .foregroundStyle(Palette.textPrimary)
                    Text(comment.createdAt.relativeShort)
                        .font(Typography.footnote)
                        .foregroundStyle(Palette.textSecondary)
                }

                Text(comment.text)
                    .font(Typography.body)
                    .foregroundStyle(Palette.textPrimary)

                Button("Ответить", action: onReply)
                    .font(Typography.footnote)
                    .foregroundStyle(Palette.textSecondary)
            }

            Spacer(minLength: 0)
        }
    }
}
