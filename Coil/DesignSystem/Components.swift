import SwiftUI

struct AvatarView: View {
    let user: User
    var size: CGFloat = Metrics.avatarMedium
    var showsOnlineDot: Bool = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Circle()
                .fill(LinearGradient(colors: user.tint.colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size, height: size)
                .overlay {
                    Text(user.initials)
                        .font(.system(size: size * 0.38, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                }

            if showsOnlineDot && user.isOnline {
                Circle()
                    .fill(Palette.online)
                    .frame(width: size * 0.27, height: size * 0.27)
                    .overlay { Circle().stroke(Palette.surface, lineWidth: max(2, size * 0.06)) }
            }
        }
        .frame(width: size, height: size)
    }
}

struct EmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 34, weight: .medium))
                .foregroundStyle(Palette.textSecondary)
            Text(title)
                .font(Typography.headline)
                .foregroundStyle(Palette.textPrimary)
            Text(subtitle)
                .font(Typography.caption)
                .foregroundStyle(Palette.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 48)
        .frame(maxWidth: .infinity)
    }
}

struct GlassIconButton: View {
    let systemImage: String
    var badgeCount: Int = 0
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: systemImage)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Palette.textPrimary)
                    .frame(width: 38, height: 38)
                    .glassCircle(interactive: true)

                if badgeCount > 0 {
                    Text(badgeCount > 9 ? "9+" : "\(badgeCount)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Palette.destructive, in: Capsule())
                        .offset(x: 6, y: -6)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
