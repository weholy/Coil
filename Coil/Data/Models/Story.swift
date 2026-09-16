import Foundation

struct StoryGroup: Identifiable, Hashable {
    let id: Int
    let authors: [User]
    let isSeen: Bool
    let segmentCount: Int
}
