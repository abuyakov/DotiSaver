import Foundation
import UIKit

extension UIView {
    
    private func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration) {
                self.alpha = alpha
            }
        }
    }

    func fadeIn(_ duration: TimeInterval = 1.5) {
        fadeTo(1.0, duration: duration)
    }

    func fadeOut(_ duration: TimeInterval = 1.5) {
        fadeTo(0.0, duration: duration)
    }
    
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
//    enum Direction: Int {
//        case topToBottom = 0
//        case bottomToTop
//        case leftToRight
//        case rightToLeft
//        case customdirect
//    }
//
//    func applyGradient(colors: [Any]?, locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .topToBottom) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.bounds
//        gradientLayer.colors = colors
//        gradientLayer.locations = locations
//
//        switch direction {
//        case .topToBottom:
//            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
//
//        case .bottomToTop:
//            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
//            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
//
//        case .leftToRight:
//            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//
//        case .rightToLeft:
//            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
//            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
//        case .customdirect:
//            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
//            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
//        }
//
//        self.layer.addSublayer(gradientLayer)
//    }
    
}

