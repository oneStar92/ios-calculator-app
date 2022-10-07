//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

@propertyWrapper
struct CleanNumber {
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

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak private var numberLabel: NumberLabel!
    @IBOutlet weak private var operatorLabel: OperatorLabel!
    @IBOutlet weak private var formulaStackView: FormulaStackView!
    @IBOutlet weak private var scrollView: UIScrollView!
    //MARK: - Properties
    private var resetList: [Resettable] = []
    private var isCalculated: Bool = false
    @CleanNumber private var numberString: String {
        didSet {
            numberLabel.text = CalculatorNumberFormatter.shared.convertedDecimalNumber(from: numberString)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetList = [numberLabel, operatorLabel, formulaStackView]
        reset()
    }
    //MARK: - IBAction
    @IBAction func touchUpOperandButton(_ sender: OperandButton) {
        checkCalculated()
        
        guard let inputNumber = sender.number else {
            return
        }
        
        numberString += inputNumber
    }
    
    @IBAction func touchUpOperatorButton(_ sender: OperatorButton) {
        checkCalculated()
        
        if numberString != "0" {
            appendFormulaIntoStackView()
            clearElement()
        }
        
        operatorLabel.text = sender.operatorSign
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
            if numberString.contains(".") == false {
                numberString += "."
            }
        case .calculation:
            if isCalculated == false {
                appendFormulaIntoStackView()
                calculateFormula()
            }
        }
    }
    //MARK: - Method
    private func reset() {
        resetList.forEach {
            $0.reset()
        }
        
        numberString = "0"
    }
    
    private func clearElement() {
        numberString = "0"
    }
    
    private func swapNumberSign() {
        guard numberString != "0" else {
            return
        }
        
        if numberString.first == "-" {
            numberString.removeFirst()
        } else {
            numberString = "-\(numberString)"
        }
    }
    
    private func appendFormulaIntoStackView() {
        formulaStackView.appendFormula(combining: operatorLabel, to: numberLabel)
        scrollView.moveToBottom()
    }
    
    private func calculateFormula() {
        var formula: Formula = ExpressionParser.parse(from: formulaStackView.formula.filter({ $0 != ","}))
        let result: Double = formula.result()
        
        if result.isInfinite || result.isNaN {
            numberLabel.text = "NaN"
        } else {
            numberLabel.text = CalculatorNumberFormatter.shared.string(for: result)
        }
        
        operatorLabel.reset()
        isCalculated = true
    }
    
    private func checkCalculated() {
        if isCalculated == true {
            reset()
            isCalculated = false
        }
    }
}

