import Foundation

struct Chat: Identifiable, Hashable {
    let id: Int
    let participant: User
    let lastMessage: Message
    let unreadCount: Int
    let isTyping: Bool
}
