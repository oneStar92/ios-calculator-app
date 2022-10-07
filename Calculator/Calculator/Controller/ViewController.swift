//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

@propertyWrapper
struct ClearNumber {
    private var value: String = "0"
    var wrappedValue: String {
        get {
            return value
        }
        set {
            if value == "0" && (newValue == "00" || newValue == "000"){
                value = "0"
            } else {
                value = newValue
            }
        }
    }
}

enum CalculatorState {
    case standBy
    case receiving
    case calculating
    case nan
}

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak private var numberLabel: NumberLabel!
    @IBOutlet weak private var operatorLabel: OperatorLabel!
    @IBOutlet weak private var formulaStackView: FormulaStackView!
    @IBOutlet weak private var scrollView: UIScrollView!
    //MARK: - Properties
    private var state: CalculatorState = .standBy
    private var resetList: [Resettable] = []
    @ClearNumber private var numberString: String {
        didSet {
            numberLabel.text = CalculatorNumberFormatter.shared.convertedDecimalNumber(from: numberString)
            
            if state == .standBy && numberString != "0" {
                state = .receiving
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetList = [numberLabel, operatorLabel, formulaStackView]
        reset()
    }
    //MARK: - IBAction
    @IBAction func touchUpOperandButton(_ sender: OperandButton) {
        guard let inputNumber = sender.number,
              state != .nan else {
            return
        }
        if state == .calculating {
            reset()
        }
        
        numberString += inputNumber
    }
    
    @IBAction func touchUpOperatorButton(_ sender: OperatorButton) {
        guard state != .standBy,
              state != .nan else {
            return
        }
        
        if numberString != "0" || state == .calculating {
            appendFormulaIntoStackView()
            numberString = "0"
        }
        
        operatorLabel.text = sender.operatorSign
        state = .receiving
    }
    
    @IBAction func touchUpCommandButton(_ sender: CommandButton) {
        guard let command: Command = sender.command else {
            return
        }
        
        switch command {
        case .allClear:
            reset()
        case .clearElement:
            clearElement()
        case .swapNumberSign:
            swapNumberSign()
        case .enterDecimalPoints:
            enterDecimalPoints()
        case .calculation:
            calculate()
        }
    }
}
//MARK: - Command Method
extension ViewController {
    private func reset() {
        resetList.forEach {
            $0.reset()
        }
        numberString = "0"
        state = .standBy
    }
    
    private func clearElement() {
        guard state != .nan else {
            return
        }
        
        if state == .calculating {
            reset()
        } else {
            numberString = "0"
        }
    }
    
    private func swapNumberSign() {
        guard numberString != "0",
              state == .receiving else {
            return
        }
        
        if numberString.first == "-" {
            numberString.removeFirst()
        } else {
            numberString = "-\(numberString)"
        }
    }
    
    private func enterDecimalPoints() {
        guard state == .receiving else {
            return
        }
        
        if numberString.contains(".") == false {
            numberString += "."
        }
    }
    
    private func calculate() {
        guard state == .receiving else {
            return
        }
        
        appendFormulaIntoStackView()
        calculateFormula()
    }
}
//MARK: - private Method
extension ViewController {
    private func appendFormulaIntoStackView() {
        formulaStackView.appendFormula(combining: operatorLabel, to: numberLabel)
        scrollView.moveToBottom()
    }
    
    private func calculateFormula() {
        var formula: Formula = ExpressionParser.parse(from: formulaStackView.formula.filter({ $0 != ","}))
        let result: Double = formula.result()
        
        if result.isInfinite || result.isNaN {
            numberLabel.text = "NaN"
            state = .nan
        } else if let formattedResult: String = CalculatorNumberFormatter.shared.string(for: result) {
            numberString = formattedResult
            state = .calculating
        }
        
        operatorLabel.reset()
    }
}

