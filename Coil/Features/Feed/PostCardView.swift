import SwiftUI

struct PostCardView: View {
    let post: Post
    var onLikeToggle: () -> Void = {}
    var onOpen: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                AvatarView(user: post.author, size: Metrics.avatarSmall)

                VStack(alignment: .leading, spacing: 1) {
                    Text(post.author.displayName)
                        .font(Typography.subheadline)
                        .foregroundStyle(Palette.textPrimary)
                    Text(post.createdAt.relativeShort)
                        .font(Typography.footnote)
                        .foregroundStyle(Palette.textSecondary)
                }

                Spacer()
            }

            Text(post.text)
                .font(Typography.body)
                .foregroundStyle(Palette.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            if post.hasImage {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Palette.hairline)
                    .aspectRatio(4/3, contentMode: .fit)
            }

            HStack(spacing: 10) {
                Button(action: onOpen) {
                    HStack(spacing: 8) {
                        Image(systemName: "bubble.left")
                            .font(.system(size: 13, weight: .medium))
                        Text("Комментировать")
                            .font(Typography.footnote)
                        Spacer()
                    }
                    .foregroundStyle(Palette.textSecondary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 9)
                }
                .buttonStyle(.plain)
                .glassCapsule()

                Button(action: onLikeToggle) {
                    HStack(spacing: 5) {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .foregroundStyle(post.isLiked ? Palette.destructive : Palette.textSecondary)
                        if post.likeCount > 0 {
                            Text("\(post.likeCount)")
                                .font(Typography.footnote)
                                .foregroundStyle(Palette.textSecondary)
                        }
                    }
                    .frame(minWidth: 38, minHeight: 38)
                    .padding(.horizontal, 10)
                }
                .buttonStyle(.plain)
                .glassCapsule()
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: Metrics.cardCornerRadius, style: .continuous)
                .fill(Palette.surface)
        }
        .overlay {
            RoundedRectangle(cornerRadius: Metrics.cardCornerRadius, style: .continuous)
                .stroke(Palette.hairline, lineWidth: 1)
        }
        .contentShape(RoundedRectangle(cornerRadius: Metrics.cardCornerRadius, style: .continuous))
        .onTapGesture(perform: onOpen)
    }
}
