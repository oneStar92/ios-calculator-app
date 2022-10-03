import Foundation

class CalculatorFormatter: NumberFormatter {
    override init() {
        super.init()
        self.numberStyle = .decimal
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func convertDecimalNumber(form text: String?, appendding number: String) -> String? {
        guard let textWithoutComma: String = text?.removedComma(),
              let number: Double = Double(textWithoutComma) else {
            return nil
        }
        return self.string(for: number)
    }
}