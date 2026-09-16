import SwiftUI

struct FeedView: View {
    @State private var folders: [FeedFolder] = [
        FeedFolder(id: 1, name: "Все", icon: "square.grid.2x2"),
        FeedFolder(id: 2, name: "Группы", icon: "person.3"),
        FeedFolder(id: 3, name: "Личное", icon: "person"),
        FeedFolder(id: 4, name: "Работа", icon: "briefcase"),
        FeedFolder(id: 5, name: "Публичное", icon: "globe")
    ]
    @State private var selectedFolderID = FeedFolderTabsView.forYouID
    @State private var stories: [StoryGroup] = []
    @State private var posts: [Post] = []
    @State private var unreadNotifications = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                FeedHeaderView(unreadNotifications: unreadNotifications, onSearchTap: {}, onNotificationsTap: {})

                FeedFolderTabsView(folders: folders, selectedFolderID: $selectedFolderID)

                StoryTrayView(stories: stories, me: CurrentUser.placeholder)

                if posts.isEmpty {
                    EmptyStateView(
                        icon: "text.bubble",
                        title: "Пока нет постов",
                        subtitle: "Здесь появятся посты тех, на кого вы подписаны"
                    )
                    .padding(.top, 24)
                } else {
                    LazyVStack(spacing: 14) {
                        ForEach(posts) { post in
                            PostCardView(post: post)
                                .scrollTransition { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0.4)
                                        .blur(radius: phase.isIdentity ? 0 : 6)
                                }
                        }
                    }
                    .padding(.horizontal, Metrics.screenPadding)
                }
            }
            .padding(.top, 8)
        }
        .background(Palette.canvas)
        .scrollIndicators(.hidden)
    }
}
