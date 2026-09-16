import SwiftUI

struct CoilTabBar: View {
    @Binding var tab: AppTab
    let onCompose: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            iconButton(.feed, icon: "house.fill")

            Spacer()

            HStack(spacing: 8) {
                Button { tab = .chats } label: {
                    Text("Chat")
                        .font(Typography.subheadline)
                        .foregroundStyle(tab == .chats ? Palette.textPrimary : Palette.textSecondary)
                        .padding(.horizontal, 18)
                        .frame(height: 48)
                }
                .buttonStyle(.plain)
                .glassCapsule(interactive: true)

                Button(action: onCompose) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Palette.canvas)
                        .frame(width: 48, height: 48)
                        .background(Circle().fill(Palette.textPrimary))
                }
                .buttonStyle(.plain)
            }

            Spacer()

            iconButton(.profile, icon: "person.fill")
        }
    }

    private func iconButton(_ value: AppTab, icon: String) -> some View {
        Button { tab = value } label: {
            Image(systemName: icon)
                .font(.system(size: 19, weight: .semibold))
                .foregroundStyle(tab == value ? Palette.textPrimary : Palette.textSecondary)
                .frame(width: 48, height: 48)
        }
        .buttonStyle(.plain)
        .glassCircle(interactive: true)
    }
}
