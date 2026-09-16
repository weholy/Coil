import SwiftUI

struct FeedHeaderView: View {
    let unreadNotifications: Int
    let onSearchTap: () -> Void
    let onNotificationsTap: () -> Void

    var body: some View {
        HStack {
            GlassIconButton(systemImage: "magnifyingglass", action: onSearchTap)

            Spacer()

            Text("Coil")
                .font(Typography.title)
                .foregroundStyle(Palette.textPrimary)

            Spacer()

            GlassIconButton(systemImage: "bell.fill", badgeCount: unreadNotifications, action: onNotificationsTap)
        }
        .padding(.horizontal, Metrics.screenPadding)
    }
}
