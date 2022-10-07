import Foundation
class CalculatorNumberFormatter {
    static let shared: CalculatorNumberFormatter = CalculatorNumberFormatter()
    private let numberFormatter: NumberFormatter = NumberFormatter()
    private init() {
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        numberFormatter.usesSignificantDigits = true
        numberFormatter.maximumSignificantDigits = 20
    }
    
    func string(for object: Any?) -> String? {
        return numberFormatter.string(for: object)
    }
    
    func convertedDecimalNumber(from numberString: String) -> String? {
        if numberString.contains(".") {
            let integerNumber = String(numberString.prefix(while: {$0 != "."}))
            let decimalNumber = String(numberString.drop(while: {$0 != "."}))
            
            guard let formattedNumber = numberFormatter.string(for: Double(integerNumber)) else {
                return nil
            }
            
            return formattedNumber + decimalNumber
        } else {
            return numberFormatter.string(for: Double(numberString))
        }
    }
}
