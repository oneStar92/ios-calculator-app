import UIKit

class CommandButton: UIButton {
    var command: CalculatorCommands? {
        return makeCommand(outof: self.restorationIdentifier)
    }
    
    private func makeCommand(outof restorationIdentifier: String?) -> CalculatorCommands? {
        guard let identifier = restorationIdentifier else {
            return nil
        }
        return CalculatorCommands.init(rawValue: identifier)
    }
}

enum CalculatorCommands: String {
    case allClear = "AC"
    case clearElement = "CE"
    case swapNumberSign = "SwapNumberSign"
    case enterDecimalPoints = "EnterDecimalPoints"
    case calculate = "Calculate"
}
