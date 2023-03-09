import Foundation

extension TimeInterval {

    var milliseconds: Int {
        return Int(self * 1_000)
    }
    
    func timeIntervalToInt() -> Int {
        return Int(self.milliseconds)
    }
    
}
