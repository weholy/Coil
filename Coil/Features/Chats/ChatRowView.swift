import SwiftUI

struct ChatRowView: View {
    let chat: Chat

    var body: some View {
        HStack(spacing: 12) {
            AvatarView(user: chat.participant, size: Metrics.avatarMedium + 8, showsOnlineDot: true)

            VStack(alignment: .leading, spacing: 3) {
                Text(chat.participant.displayName)
                    .font(Typography.headline)
                    .foregroundStyle(Palette.textPrimary)

                if chat.isTyping {
                    Text("печатает…")
                        .font(Typography.caption)
                        .foregroundStyle(Palette.accent)
                } else {
                    HStack(spacing: 4) {
                        if chat.lastMessage.isMine {
                            Image(systemName: chat.lastMessage.isRead ? "checkmark.circle.fill" : "checkmark.circle")
                                .font(.system(size: 12))
                                .foregroundStyle(Palette.textSecondary)
                        }
                        Text(messagePreview)
                            .font(Typography.caption)
                            .foregroundStyle(Palette.textSecondary)
                            .lineLimit(1)
                    }
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                Text(chat.lastMessage.createdAt.relativeShort)
                    .font(Typography.footnote)
                    .foregroundStyle(Palette.textSecondary)

                if chat.unreadCount > 0 {
                    Text("\(chat.unreadCount)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(minWidth: 18, minHeight: 18)
                        .background(Palette.accent, in: Circle())
                }
            }
        }
        .padding(.horizontal, Metrics.screenPadding)
        .padding(.vertical, 10)
    }

    private var messagePreview: String {
        switch chat.lastMessage.kind {
        case .text: chat.lastMessage.text
        case .voice: "Голосовое сообщение"
        case .image: "Фото"
        }
    }
}
