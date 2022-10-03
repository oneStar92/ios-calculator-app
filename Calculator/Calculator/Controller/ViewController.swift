//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak private var numberLabel: NumberLabel!
    @IBOutlet weak private var operatorLabel: OperatorLabel!
    @IBOutlet weak private var formulaStackView: FormulaStackView!
    @IBOutlet weak private var scrollView: UIScrollView!
    //MARK: - Properties
    private var resetList: [Resettable] = []
    private var isCalculated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetList = [numberLabel, operatorLabel, formulaStackView]
        allClear()
    }
    //MARK: - IBAction
    @IBAction func touchUpOperandButton(_ sender: OperandButton) {

    }
    
    @IBAction func touchUpOperatorButton(_ sender: OperatorButton) {
        
    }
    
    @IBAction func touchUpCommandButton(_ sender: CommandButton) {
        guard let command: CalculatorCommands = sender.command else {
            return
        }
        
        switch command {
        case .allClear:
            execute(allClear)
        case .clearElement:
            execute(clearElement)
        case .swapNumberSign:
            execute(swapNumberSign)
        case .enterDecimalPoints:
            execute(enterDecimalPoints)
        case .calculate:
            execute(calculate)
        }
    }
    //MARK: - Method
    
    private func execute(_ command: () -> Void) {
        command()
    }
    
    private func appendFormulaIntoStackView() {
        formulaStackView.appendFormula(combining: operatorLabel, to: numberLabel)
        scrollView.moveToBottom()
    }
}
//MARK: - Command Func
extension ViewController {
    private func allClear() {
        resetList.forEach {
            $0.reset()
        }
    }
    
    private func clearElement() {
        numberLabel.reset()
    }
    
    private func swapNumberSign() {
        
    }
    
    private func enterDecimalPoints() {
        
    }
    
    private func calculate() {
        var formula: Formula = ExpressionParser.parse(from: formulaStackView.formula.removedComma())
        let result: Double = formula.result()
        
        if result.isInfinite || result.isNaN {
            let notANumber: String = "NaN"
            numberLabel.text = notANumber
        } else {
            numberLabel.text = String(result)
        }
        
        operatorLabel.reset()
    }
}
