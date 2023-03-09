import Foundation
import UIKit

class PlayerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func internalInit() {
        frame.size = CGSize(width: 10 * 2, height: 10 * 2)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .tintColor
    }
    
}
