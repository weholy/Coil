import SwiftUI

struct SettingsView: View {
    @AppStorage("colorSchemePreference") private var colorSchemeRaw = ColorSchemePreference.system.rawValue
    @AppStorage("chatWallpaperMode") private var wallpaperModeRaw = ChatWallpaperMode.minimalist.rawValue

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                appearanceSection
                wallpaperSection
                otherSettingsSection
            }
            .padding(Metrics.screenPadding)
        }
        .background(Palette.canvas)
        .navigationTitle("Настройки")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var appearanceSection: some View {
        VStack(spacing: 14) {
            Text("Оформление")
                .font(Typography.headline)
                .foregroundStyle(Palette.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 10) {
                ForEach(ColorSchemePreference.allCases, id: \.self) { option in
                    schemeButton(option)
                }
            }
        }
    }

    private func schemeButton(_ option: ColorSchemePreference) -> some View {
        let isSelected = colorSchemeRaw == option.rawValue
        return Button {
            colorSchemeRaw = option.rawValue
        } label: {
            Text(option.title)
                .font(Typography.subheadline)
                .foregroundStyle(isSelected ? Palette.canvas : Palette.textPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(isSelected ? Palette.textPrimary : Palette.surface)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Palette.hairline, lineWidth: isSelected ? 0 : 1)
                }
        }
        .buttonStyle(.plain)
    }

    private var wallpaperSection: some View {
        VStack(spacing: 14) {
            Text("Оформление чата")
                .font(Typography.headline)
                .foregroundStyle(Palette.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 12) {
                ForEach(ChatWallpaperMode.allCases, id: \.self) { mode in
                    wallpaperCard(mode)
                }
            }
        }
    }

    private func wallpaperCard(_ mode: ChatWallpaperMode) -> some View {
        let isSelected = wallpaperModeRaw == mode.rawValue
        return Button {
            wallpaperModeRaw = mode.rawValue
        } label: {
            VStack(spacing: 10) {
                chatPreview(mode)
                    .frame(height: 90)

                Text(mode.title)
                    .font(Typography.footnote)
                    .foregroundStyle(isSelected ? Palette.textPrimary : Palette.textSecondary)
            }
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Palette.surface)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(isSelected ? Palette.textPrimary : Palette.hairline, lineWidth: isSelected ? 2 : 1)
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func chatPreview(_ mode: ChatWallpaperMode) -> some View {
        let bubbles = VStack(alignment: .leading, spacing: 6) {
            bubblePreview(width: 60, isMine: false)
            bubblePreview(width: 44, isMine: true)
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

        switch mode {
        case .minimalist:
            bubbles.background(Palette.canvas, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        case .colorful:
            bubbles.background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(LinearGradient(colors: [Palette.accent.opacity(0.28), Palette.accent.opacity(0.06)], startPoint: .top, endPoint: .bottom))
            }
        }
    }

    private func bubblePreview(width: CGFloat, isMine: Bool) -> some View {
        Capsule()
            .fill(isMine ? Palette.bubbleMine : Palette.bubbleOther)
            .frame(width: width, height: 14)
            .frame(maxWidth: .infinity, alignment: isMine ? .trailing : .leading)
    }

    private var otherSettingsSection: some View {
        VStack(spacing: 0) {
            settingsRow(icon: "lock", title: "Конфиденциальность")
            rowDivider
            settingsRow(icon: "bell", title: "Уведомления")
            rowDivider
            settingsRow(icon: "person.crop.circle", title: "Аккаунт")
            rowDivider
            settingsRow(icon: "questionmark.circle", title: "Помощь")
        }
        .background {
            RoundedRectangle(cornerRadius: Metrics.cardCornerRadius, style: .continuous)
                .fill(Palette.surface)
        }
        .overlay {
            RoundedRectangle(cornerRadius: Metrics.cardCornerRadius, style: .continuous)
                .stroke(Palette.hairline, lineWidth: 1)
        }
    }

    private var rowDivider: some View {
        Rectangle()
            .fill(Palette.hairline)
            .frame(height: 1)
            .padding(.leading, 52)
    }

    private func settingsRow(icon: String, title: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Palette.textSecondary)
                .frame(width: 24)

            Text(title)
                .font(Typography.body)
                .foregroundStyle(Palette.textPrimary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Palette.textSecondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .contentShape(Rectangle())
    }
}
