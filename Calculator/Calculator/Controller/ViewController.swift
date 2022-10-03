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
        initialization()
    }
    //MARK: - IBAction
    @IBAction func touchUpOperandButton(_ sender: OperandButton) {

    }
    
    @IBAction func touchUpOperatorButton(_ sender: OperatorButton) {
        
    }
    
    @IBAction func touchUpCommandButton(_ sender: CommandButton) {
        guard let command: Command = sender.command else {
            return
        }
        
        switch command {
        case .allClear:
            initialization()
        case .clearElement:
            numberLabel.reset()
        case .swapNumberSign:
            return
        case .enterDecimalPoints:
            return
        case .calculation:
            appendFormulaIntoStackView()
            calculateFormula()
        }
    }
    //MARK: - Method
    private func initialization() {
        resetList.forEach {
            $0.reset()
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
            return
        }
        
        operatorLabel.reset()
    }
}

