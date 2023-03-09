import Foundation
import UIKit

class EnemyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func internalInit() {
        bounds.size = CGSize(width: 10, height: 10)
        layer.cornerRadius = 2
        layer.masksToBounds = true
        backgroundColor = AppearanceManager.shared.enemycolor.getColorStyle()
    }
    
}
