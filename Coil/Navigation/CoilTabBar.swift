import SwiftUI

struct CoilTabBar: View {
    @Binding var tab: AppTab
    let onCompose: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            tabButton(.feed, icon: "house.fill")

            Spacer()

            Button { tab = .chats } label: {
                HStack(spacing: 6) {
                    Image(systemName: "bubble.left.fill")
                        .font(.system(size: 17, weight: .semibold))
                    Text("Chat")
                        .font(Typography.subheadline)
                }
                .foregroundStyle(tab == .chats ? Palette.textPrimary : Palette.textSecondary)
            }
            .buttonStyle(.plain)

            Button(action: onCompose) {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .background(Palette.accent, in: Circle())
            }
            .padding(.leading, 10)

            Spacer()

            tabButton(.profile, icon: "person.crop.circle.fill")
        }
        .padding(.horizontal, 22)
        .frame(height: Metrics.tabBarHeight)
        .glassCapsule(interactive: true)
    }

    private func tabButton(_ value: AppTab, icon: String) -> some View {
        Button { tab = value } label: {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(tab == value ? Palette.accent : Palette.textSecondary)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
    }
}
