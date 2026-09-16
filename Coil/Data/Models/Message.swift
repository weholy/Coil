import Foundation

enum MessageKind: Hashable {
    case text
    case voice(duration: Int)
    case image
}

struct Message: Identifiable, Hashable {
    let id: Int
    let sender: User
    let text: String
    let createdAt: Date
    let isMine: Bool
    let kind: MessageKind
    let isRead: Bool
}
