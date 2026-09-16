import SwiftUI

struct MainTabsView: View {
    @State private var tab: AppTab = .feed
    @State private var isComposingPost = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Palette.canvas.ignoresSafeArea()

            Group {
                switch tab {
                case .feed: FeedView()
                case .chats: ChatsListView()
                case .profile: ProfileView()
                }
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: Metrics.tabBarHeight + 24)
            }

            CoilTabBar(tab: $tab, onCompose: { isComposingPost = true })
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
        }
        .sheet(isPresented: $isComposingPost) {
            ComposePostView()
        }
    }
}
