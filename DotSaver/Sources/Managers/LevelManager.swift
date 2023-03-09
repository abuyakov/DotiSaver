import Foundation


struct LevelManager {
    
    func increaseDifficulty(countTime: TimeInterval) -> (displaySpeed: Double, enemySpeed: CGFloat) {
        switch countTime {
        case 0..<10:
            return (1.2, 60)
        case 10..<30:
            return (1.0, 80)
        case 30..<80:
            return (0.8, 100)
        case 80..<90:
            return (0.5, 100)
        case 90..<120:
            return (0.4, 80)
        case 120..<140:
            return (0.8, 120)
        case 140..<200:
            return (0.5, 80)
        default:
            return (0.5, 100)
        }
    }
    
}
