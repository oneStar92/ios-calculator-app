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
            return textWithoutComma + enteredNumber
        } else {
            return self.string(for: number)
        }
    }
    
    func swapNumberSign(for number: String?) -> String? {
        guard let numberWithoutComma: String = number?.removedComma() else {
            return number
        }
        
        if numberWithoutComma.first == negativeSign {
            return String(numberWithoutComma.dropFirst())
        } else {
            return String(negativeSign) + numberWithoutComma
        }
    }
    
    func enterDecimalPoint(for number: String?) -> String? {
        guard let number = number else {
            return number
        }
        
        if number.contains(decimalPoint) {
            return number
        } else {
            return number + String(decimalPoint)
        }
    }
}
