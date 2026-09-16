import SwiftUI

struct ChatDetailView: View {
    let participant: User
    @State private var messages: [Message] = []
    @State private var inputText = ""

    var body: some View {
        VStack(spacing: 0) {
            if messages.isEmpty {
                Spacer()
                EmptyStateView(
                    icon: "bubble.left.and.bubble.right",
                    title: "Пока нет сообщений",
                    subtitle: "Напишите первым — переписка появится здесь"
                )
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(messages) { message in
                            MessageBubbleView(message: message)
                        }
                    }
                    .padding(.horizontal, Metrics.screenPadding)
                    .padding(.top, 12)
                }
                .scrollIndicators(.hidden)
            }

            ChatInputBar(text: $inputText, onSend: sendMessage)
        }
        .background(Palette.canvas)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                chatHeader
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "phone.fill")
                        .foregroundStyle(Palette.textPrimary)
                }
            }
        }
    }

    private var chatHeader: some View {
        HStack(spacing: 8) {
            AvatarView(user: participant, size: 32, showsOnlineDot: true)

            VStack(alignment: .leading, spacing: 0) {
                Text(participant.displayName)
                    .font(Typography.subheadline)
                    .foregroundStyle(Palette.textPrimary)
                Text(participant.isOnline ? "в сети" : participant.lastSeenText)
                    .font(Typography.footnote)
                    .foregroundStyle(Palette.textSecondary)
            }
        }
    }

    private func sendMessage() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        messages.append(
            Message(
                id: messages.count,
                sender: CurrentUser.placeholder,
                text: trimmed,
                createdAt: Date(),
                isMine: true,
                kind: .text,
                isRead: false
            )
        )
        inputText = ""
    }
}
