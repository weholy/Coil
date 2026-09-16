import SwiftUI

struct ProfileView: View {
    private let user = CurrentUser.placeholder
    @State private var selectedTab = 0
    private let tabs = ["Медиа", "Файлы", "Ссылки"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        AvatarView(user: user, size: Metrics.avatarLarge)

                        Text(user.displayName)
                            .font(Typography.title)
                            .foregroundStyle(Palette.textPrimary)

                        Text("@\(user.username) · ID \(user.id)")
                            .font(Typography.caption)
                            .foregroundStyle(Palette.textSecondary)
                    }
                    .padding(.top, 12)

                    Button("Редактировать профиль") {}
                        .font(Typography.subheadline)
                        .foregroundStyle(Palette.textPrimary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .glassCapsule(interactive: true)

                    HStack(spacing: 0) {
                        statColumn(value: 0, title: "Посты")
                        statColumn(value: 0, title: "Подписчики")
                        statColumn(value: 0, title: "Подписки")
                    }

                    VStack(spacing: 16) {
                        HStack(spacing: 24) {
                            ForEach(Array(tabs.enumerated()), id: \.offset) { index, title in
                                Button {
                                    selectedTab = index
                                } label: {
                                    Text(title)
                                        .font(Typography.subheadline)
                                        .foregroundStyle(selectedTab == index ? Palette.textPrimary : Palette.textSecondary)
                                        .padding(.bottom, 8)
                                        .overlay(alignment: .bottom) {
                                            if selectedTab == index {
                                                Rectangle().fill(Palette.textPrimary).frame(height: 2)
                                            }
                                        }
                                }
                                .buttonStyle(.plain)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, Metrics.screenPadding)
                        .overlay(alignment: .bottom) {
                            Rectangle().fill(Palette.hairline).frame(height: 1)
                        }

                        EmptyStateView(icon: emptyIcon, title: "Пока пусто", subtitle: emptySubtitle)
                    }
                    .padding(.top, 4)
                }
            }
            .background(Palette.canvas)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundStyle(Palette.textPrimary)
                    }
                }
            }
        }
    }

    private var emptyIcon: String {
        switch tabs[selectedTab] {
        case "Медиа": "photo.on.rectangle"
        case "Файлы": "doc"
        default: "link"
        }
    }

    private var emptySubtitle: String {
        switch tabs[selectedTab] {
        case "Медиа": "Фото и видео из постов и чатов появятся здесь"
        case "Файлы": "Файлы, которыми с вами поделились, будут здесь"
        default: "Ссылки из переписки появятся здесь"
        }
    }

    private func statColumn(value: Int, title: String) -> some View {
        VStack(spacing: 2) {
            Text("\(value)")
                .font(Typography.headline)
                .foregroundStyle(Palette.textPrimary)
            Text(title)
                .font(Typography.footnote)
                .foregroundStyle(Palette.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}
