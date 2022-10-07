import UIKit

class OperatorButton: UIButton {
    private let operatorDictionary: [String: String] = ["add": "+", "subtract": "−", "divide": "÷", "multiply": "×"]
    var operatorSign: String? {
        return makeOperatorSign(outof: self.restorationIdentifier)
    }
    
    private func makeOperatorSign(outof restorationIdentifier: String?) -> String? {
        guard let identifier = restorationIdentifier,
              let operatorSign = operatorDictionary[identifier] else {
            return nil
        }
        return operatorSign
    }
}
