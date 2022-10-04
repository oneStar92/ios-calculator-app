import Foundation

class CalculatorFormatter: NumberFormatter {
    private let decimalPoint: Character = "."
    private let negativeSign: Character = "-"
    private let maximumNumberLength: Int = 20
    private let infinitySymbol: String = "NaN"
    
    override init() {
        super.init()
        self.numberStyle = .decimal
        self.maximumIntegerDigits = maximumNumberLength
        self.maximumFractionDigits = maximumNumberLength
        self.negativeInfinitySymbol = infinitySymbol
        self.positiveInfinitySymbol = infinitySymbol
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func convertDecimalNumber(form text: String?, appendding enteredNumber: String) -> String? {
        guard let textWithoutComma: String = text?.removedComma(),
              textWithoutComma.count < 20,
              let number: Double = Double(textWithoutComma + enteredNumber) else {
            return text
        }
        
        if textWithoutComma.contains(decimalPoint) {
            var textWithComma: String? = text
            textWithComma?.append(enteredNumber)
            return textWithComma
        } else {
            return self.string(for: number)
        }
    }
    
    func swapNumberSign(for number: String?) -> String? {
        guard let numberWithComma: String = number else {
            return number
        }
        
        if numberWithComma.first == negativeSign {
            return String(numberWithComma.dropFirst())
        } else {
            return String(negativeSign) + numberWithComma
        }
    }
    
    func enterDecimalPoint(for number: String?) -> String? {
        guard let numberWithComma = number else {
            return number
        }
        
        if numberWithComma.contains(decimalPoint) {
            return number
        } else {
            return numberWithComma + String(decimalPoint)
        }
    }
}
