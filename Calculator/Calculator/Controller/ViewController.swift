//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
enum CalculatorState {
    case standBy
    case receiving
    case calculating
}

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak private var numberLabel: NumberLabel!
    @IBOutlet weak private var operatorLabel: OperatorLabel!
    @IBOutlet weak private var formulaStackView: FormulaStackView!
    @IBOutlet weak private var scrollView: UIScrollView!
    //MARK: - Properties
    private var resetList: [Resettable] = []
    private let formatter: CalculatorFormatter = CalculatorFormatter()
    private var state: CalculatorState = .standBy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetList = [numberLabel, operatorLabel, formulaStackView]
        allClear()
    }
    //MARK: - IBAction
    @IBAction func touchUpOperandButton(_ sender: OperandButton) {
        guard let number: String = sender.number else {
            return
        }
        if state == .calculating {
            allClear()
        }
        numberLabel.text = formatter.convertDecimalNumber(form: numberLabel.text, appendding: number)
        state = .receiving
    }
    
    @IBAction func touchUpOperatorButton(_ sender: OperatorButton) {
        guard let operatorSign: String = sender.operatorSign,
              state != .standBy else {
            return
        }
        
        appendFormulaIntoStackView()
        numberLabel.reset()
        operatorLabel.text = operatorSign
        state = .receiving
    }
    
    @IBAction func touchUpCommandButton(_ sender: CommandButton) {
        guard let command: CalculatorCommand = sender.command else {
            return
        }
        
        switch command {
        case .allClear:
            allClear()
        case .clearElement:
            clearElement()
        case .swapNumberSign:
            swapNumberSign()
        case .enterDecimalPoints:
            enterDecimalPoints()
        case .calculate:
            if state == .receiving {
                appendFormulaIntoStackView()
                calculate()
            }
        }
    }
    //MARK: - Method
    private func appendFormulaIntoStackView() {
        formulaStackView.appendFormula(combining: operatorLabel, to: numberLabel)
        scrollView.moveToBottom()
    }
}
//MARK: - Command Method
extension ViewController {
    private func allClear() {
        resetList.forEach {
            $0.reset()
        }
        state = .standBy
    }
    
    private func clearElement() {
        if state == .calculating {
            allClear()
        } else {
            numberLabel.reset()
        }
    }
    
    private func swapNumberSign() {
        numberLabel.text = formatter.swapNumberSign(for: numberLabel.text)
    }
    
    private func enterDecimalPoints() {
        numberLabel.text = formatter.enterDecimalPoint(for: numberLabel.text)
    }
    
    private func calculate() {
        var formula: Formula = ExpressionParser.parse(from: formulaStackView.formula.removedComma())
        let result: Double = formula.result()
        
        numberLabel.text = formatter.string(for: result)
        operatorLabel.reset()
        state = .calculating
    }
}
