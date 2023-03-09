import Foundation
import UIKit

struct AppearanceManager {
    
    static var shared = AppearanceManager()
    
    var theme: Themes {
        get {
            Themes(rawValue: UserDefaults.standard.integer(forKey: DefaultKeys.selectedTheme)) ?? .auto
        } set {
            UserDefaults.standard.set(newValue.rawValue, forKey: DefaultKeys.selectedTheme)
        }
    }
    
    var playercolor: Colors {
        get {
            Colors(rawValue: UserDefaults.standard.integer(forKey: DefaultKeys.selectedPlayerColor)) ?? .wb
        } set {
            UserDefaults.standard.set(newValue.rawValue, forKey: DefaultKeys.selectedPlayerColor)
        }
    }
    
    var enemycolor: Colors {
        get {
            Colors(rawValue: UserDefaults.standard.integer(forKey: DefaultKeys.selectedEnemyColor)) ?? .random
        } set {
            UserDefaults.standard.set(newValue.rawValue, forKey: DefaultKeys.selectedEnemyColor)
        }
    }
    
}

enum Themes: Int {
    
    case auto
    case light
    case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .auto:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    func descriptions() -> String {
        switch self {
        case .auto:
            return "System"
        case .light:
            return "Always Light"
        case .dark:
            return "Always Dark"
        }
    }
    
}

enum Colors: Int {
    
    case wb
    case red
    case orange
    case yellow
    case green
    case mint
    case teal
    case cyan
    case blue
    case indigo
    case purple
    case pink
    case brown
    case random
    
    private func getRandomColor() -> UIColor {
        let colors = [UIColor.systemRed, UIColor.systemOrange, UIColor.systemYellow,
                      UIColor.systemGreen, UIColor.systemMint, UIColor.systemTeal,
                      UIColor.systemCyan, UIColor.systemBlue, UIColor.systemIndigo,
                      UIColor.systemPurple, UIColor.systemPink, UIColor.systemBrown,]
        let index = arc4random_uniform(UInt32(colors.count))
        return colors[Int(index)]
    }
    
    func getColorStyle() -> UIColor {
        switch self {
        case .wb:
            return .label
        case .red:
            return .systemRed
        case .orange:
            return .systemOrange
        case .yellow:
            return .systemYellow
        case .green:
            return .systemGreen
        case .mint:
            return .systemMint
        case .teal:
            return .systemTeal
        case .cyan:
            return .systemCyan
        case .blue:
            return .systemBlue
        case .indigo:
            return .systemIndigo
        case .purple:
            return .systemPurple
        case .pink:
            return .systemPink
        case .brown:
            return .systemBrown
        case .random:
            return getRandomColor()
        }
    }
    
    func descriptions() -> String {
        switch self {
        case .wb:
            return "White / Black"
        case .red:
            return "Red"
        case .orange:
            return "Orange"
        case .yellow:
            return "Yellow"
        case .green:
            return "Green"
        case .mint:
            return "Mint"
        case .teal:
            return "Teal"
        case .cyan:
            return "Cyan"
        case .blue:
            return "Blue"
        case .indigo:
            return "Indigo"
        case .purple:
            return "Purple"
        case .pink:
            return "Pink"
        case .brown:
            return "Brown"
        case .random:
            return "Random"
        }
    }
    
}

