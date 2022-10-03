import UIKit

class NumberLabel: UILabel {
    //MARK: - NumberLabel NameSpace
    private let initialValue: String = "0"
}

//MARK: - extension
extension NumberLabel: Resettable {
    func reset() {
        self.text = initialValue
    }
}
