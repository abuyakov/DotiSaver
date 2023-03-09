import Foundation
import UIKit

extension UIFeedbackGenerator {
    
    enum StyleFeedbackGenerator {
        case light
        case medium
        case heavy
        case soft
        case rigid
        case notificationError
        case notificationSuccess
        case notificationWarning
        case selectionChanged
    }
    
    static func impactOccurred(_ style: StyleFeedbackGenerator) {
        switch style {
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        case .soft:
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred()
        case .rigid:
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred()
        case .notificationError:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.error)
        case .notificationSuccess:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
        case .notificationWarning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.warning)
        case .selectionChanged:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
}

