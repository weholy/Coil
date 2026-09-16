import Foundation

enum ColorSchemePreference: String, CaseIterable {
    case system, dark, light

    var title: String {
        switch self {
        case .system: "Системная"
        case .dark: "Тёмная"
        case .light: "Светлая"
        }
    }
}

enum ChatWallpaperMode: String, CaseIterable {
    case minimalist, colorful

    var title: String {
        switch self {
        case .minimalist: "Минимализм"
        case .colorful: "Цветной"
        }
    }
}
