import SwiftUI

struct ChatsListView: View {
    @State private var chats: [Chat] = []

    var body: some View {
        NavigationStack {
            Group {
                if chats.isEmpty {
                    EmptyStateView(
                        icon: "bubble.left.and.bubble.right",
                        title: "Пока нет чатов",
                        subtitle: "Начните переписку — и она появится здесь"
                    )
                    .padding(.top, 60)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 2) {
                            ForEach(chats) { chat in
                                NavigationLink(value: chat.participant) {
                                    ChatRowView(chat: chat)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .background(Palette.canvas)
            .navigationTitle("Сообщения")
            .navigationDestination(for: User.self) { participant in
                ChatDetailView(participant: participant)
            }
        }
    }
}
