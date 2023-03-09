import Foundation

extension Int {
    
    func intToString() -> String {
       let numberFormatter = NumberFormatter()
       numberFormatter.numberStyle = NumberFormatter.Style.decimal
       numberFormatter.groupingSeparator = "."
        
       let formattedNumber = numberFormatter.string(from: self as NSNumber)
       return formattedNumber!
    }
    
}
