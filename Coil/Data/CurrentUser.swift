import Foundation

enum CurrentUser {
    static let placeholder = User(
        id: 0,
        username: "you",
        displayName: "Профиль",
        tint: .rose,
        isOnline: true,
        lastSeenText: "в сети"
    )
}
