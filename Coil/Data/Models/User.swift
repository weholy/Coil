import SwiftUI

enum AvatarTint: CaseIterable {
    case rose, amber, mint, sky, violet, slate

    var colors: [Color] {
        switch self {
        case .rose: [Color(red: 0.84, green: 0.49, blue: 0.52), Color(red: 0.72, green: 0.33, blue: 0.4)]
        case .amber: [Color(red: 0.95, green: 0.65, blue: 0.35), Color(red: 0.88, green: 0.5, blue: 0.22)]
        case .mint: [Color(red: 0.42, green: 0.78, blue: 0.65), Color(red: 0.26, green: 0.62, blue: 0.55)]
        case .sky: [Color(red: 0.45, green: 0.68, blue: 0.92), Color(red: 0.28, green: 0.5, blue: 0.82)]
        case .violet: [Color(red: 0.62, green: 0.55, blue: 0.88), Color(red: 0.46, green: 0.38, blue: 0.76)]
        case .slate: [Color(red: 0.55, green: 0.58, blue: 0.63), Color(red: 0.38, green: 0.41, blue: 0.46)]
        }
    }
}

struct User: Identifiable, Hashable {
    let id: Int
    let username: String
    let displayName: String
    let tint: AvatarTint
    let isOnline: Bool
    let lastSeenText: String

    var initials: String {
        let letters = displayName.split(separator: " ").prefix(2).compactMap { $0.first }
        return String(letters).uppercased()
    }
}
