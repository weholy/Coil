import SwiftUI

struct PostDetailView: View {
    let post: Post
    @State private var commentText = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 10) {
                    AvatarView(user: post.author, size: Metrics.avatarMedium)
                    VStack(alignment: .leading, spacing: 1) {
                        Text(post.author.displayName)
                            .font(Typography.headline)
                            .foregroundStyle(Palette.textPrimary)
                        Text("@\(post.author.username)")
                            .font(Typography.caption)
                            .foregroundStyle(Palette.textSecondary)
                    }
                    Spacer()
                }

                Text(post.text)
                    .font(Typography.body)
                    .foregroundStyle(Palette.textPrimary)

                if post.hasImage {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Palette.hairline)
                        .aspectRatio(4 / 3, contentMode: .fit)
                }

                Text(post.createdAt.relativeShort)
                    .font(Typography.footnote)
                    .foregroundStyle(Palette.textSecondary)

                actionsRow
                    .padding(.vertical, 6)

                Rectangle()
                    .fill(Palette.hairline)
                    .frame(height: 1)

                if post.comments.isEmpty {
                    EmptyStateView(
                        icon: "bubble.left",
                        title: "Пока нет комментариев",
                        subtitle: "Будьте первым, кто оставит комментарий"
                    )
                } else {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(post.comments) { comment in
                            CommentRowView(comment: comment)
                        }
                    }
                    .padding(.top, 4)
                }
            }
            .padding(Metrics.screenPadding)
        }
        .background(Palette.canvas)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            commentInputBar
        }
    }

    private var actionsRow: some View {
        HStack(spacing: 26) {
            actionStat(icon: post.isLiked ? "heart.fill" : "heart", count: post.likeCount, tint: post.isLiked ? Palette.destructive : Palette.textSecondary)
            actionStat(icon: "arrow.2.squarepath", count: post.repostCount, tint: Palette.textSecondary)
            actionStat(icon: "bubble.left", count: post.comments.count, tint: Palette.textSecondary)
            Spacer()
        }
    }

    private func actionStat(icon: String, count: Int, tint: Color) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(tint)
            if count > 0 {
                Text("\(count)")
                    .font(Typography.footnote)
                    .foregroundStyle(Palette.textSecondary)
            }
        }
    }

    private var commentInputBar: some View {
        HStack(spacing: 10) {
            TextField("Комментировать", text: $commentText)
                .font(Typography.body)
                .padding(.horizontal, 14)
                .frame(height: 40)
                .glassCapsule()

            Button {
                commentText = ""
            } label: {
                Image(systemName: "arrow.up")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(commentText.trimmingCharacters(in: .whitespaces).isEmpty ? Palette.textSecondary : Palette.textPrimary)
                    .frame(width: 38, height: 38)
            }
            .buttonStyle(.plain)
            .glassCircle(interactive: true)
            .disabled(commentText.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding(.horizontal, Metrics.screenPadding)
        .padding(.vertical, 10)
    }
}
