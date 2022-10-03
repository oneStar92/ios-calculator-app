import UIKit

class CommandButton: UIButton {
    var command: CalculatorCommand? {
        return makeCommand(outof: self.restorationIdentifier)
    }
    
    private func makeCommand(outof restorationIdentifier: String?) -> CalculatorCommand? {
        guard let identifier = restorationIdentifier else {
            return nil
        }
        return CalculatorCommand.init(rawValue: identifier)
    }
}

enum CalculatorCommand: String {
    case allClear = "AC"
    case clearElement = "CE"
    case swapNumberSign = "SwapNumberSign"
    case enterDecimalPoints = "EnterDecimalPoints"
    case calculate = "Calculate"
}
