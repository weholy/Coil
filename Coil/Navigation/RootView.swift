import SwiftUI

struct RootView: View {
    @AppStorage("colorSchemePreference") private var colorSchemeRaw = ColorSchemePreference.system.rawValue

    var body: some View {
        MainTabsView()
            .preferredColorScheme(preferredColorScheme)
    }

    private var preferredColorScheme: ColorScheme? {
        switch ColorSchemePreference(rawValue: colorSchemeRaw) ?? .system {
        case .system: nil
        case .dark: .dark
        case .light: .light
        }
    }
}
