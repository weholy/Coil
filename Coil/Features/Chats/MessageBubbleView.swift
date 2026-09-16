import SwiftUI
import UIKit

struct MessageBubbleView: View {
    let message: Message
    var onReply: () -> Void = {}
    var onForward: () -> Void = {}
    var onPin: () -> Void = {}
    var onDelete: () -> Void = {}

    var body: some View {
        HStack {
            if message.isMine { Spacer(minLength: 40) }

            VStack(alignment: message.isMine ? .trailing : .leading, spacing: 4) {
                content
                    .contextMenu {
                        Button(action: onReply) {
                            Label("Ответить", systemImage: "arrowshape.turn.up.left")
                        }
                        Button(action: copyText) {
                            Label("Скопировать", systemImage: "doc.on.doc")
                        }
                        Button(action: onForward) {
                            Label("Переслать", systemImage: "arrowshape.turn.up.right")
                        }
                        Button(action: onPin) {
                            Label("Закрепить", systemImage: "pin")
                        }
                        Button(role: .destructive, action: onDelete) {
                            Label("Удалить", systemImage: "trash")
                        }
                    }

                HStack(spacing: 4) {
                    Text(message.createdAt.timeString)
                        .font(Typography.footnote)
                        .foregroundStyle(Palette.textSecondary)

                    if message.isMine {
                        Image(systemName: message.isRead ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 11))
                            .foregroundStyle(Palette.textSecondary)
                    }
                }
                .padding(.horizontal, 4)
            }

            if !message.isMine { Spacer(minLength: 40) }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch message.kind {
        case .text:
            Text(message.text)
                .font(Typography.body)
                .foregroundStyle(message.isMine ? Palette.bubbleTextMine : Palette.bubbleTextOther)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(message.isMine ? Palette.bubbleMine : Palette.bubbleOther, in: bubbleShape)

        case .voice(let duration):
            VoiceMessageBubble(isMine: message.isMine, duration: duration)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(message.isMine ? Palette.bubbleMine : Palette.bubbleOther, in: bubbleShape)

        case .image:
            RoundedRectangle(cornerRadius: Metrics.bubbleCornerRadius, style: .continuous)
                .fill(Palette.hairline)
                .frame(width: 220, height: 220)
        }
    }

    private var bubbleShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: Metrics.bubbleCornerRadius, style: .continuous)
    }

    private func copyText() {
        guard case .text = message.kind else { return }
        UIPasteboard.general.string = message.text
    }
}
