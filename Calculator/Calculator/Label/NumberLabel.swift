import UIKit

class NumberLabel: UILabel, Resettable {
    private let initialValue: String = "0"
    func reset() {
        self.text = initialValue
    }
}
