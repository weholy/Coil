import SwiftUI

struct FeedView: View {
    @State private var stories: [StoryGroup] = []
    @State private var posts: [Post] = []
    @State private var unreadNotifications = 0
    @State private var selectedPost: Post?
    @State private var selectedStoryGroup: StoryGroup?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    FeedHeaderView(unreadNotifications: unreadNotifications, onSearchTap: {}, onNotificationsTap: {})

                    StoryTrayView(stories: stories, me: CurrentUser.placeholder, onSelect: { selectedStoryGroup = $0 })

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
                                PostCardView(post: post, onOpen: { selectedPost = post })
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
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(item: $selectedPost) { post in
                PostDetailView(post: post)
            }
        }
        .fullScreenCover(item: $selectedStoryGroup) { group in
            StoryViewerView(group: group)
        }
    }
}
