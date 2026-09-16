import Foundation

struct Comment: Identifiable, Hashable {
    let id: Int
    let author: User
    let text: String
    let createdAt: Date
}

struct Post: Identifiable, Hashable {
    let id: Int
    let author: User
    let createdAt: Date
    let text: String
    let hasImage: Bool
    var likeCount: Int
    var isLiked: Bool
    var comments: [Comment]
    var repostCount: Int
}
