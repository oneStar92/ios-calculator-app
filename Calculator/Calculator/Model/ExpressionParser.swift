enum ExpressionParser {
    static func parse(from input: String) -> Formula {
        var formula = Formula()
        let componentsResult = self.componentsByOperators(from: input)
        
        componentsResult.forEach {
            enqueue($0, in: &formula)
        }
        
        return formula
    }
    
    private static func componentsByOperators(from input: String) -> [String] {
        var componentsResult: [String] = [input]
        
        Operator.allCases.forEach { `operator` in
            var splitResult: [String] = []
            
            componentsResult.forEach {
                splitResult += $0.split(with: `operator`.rawValue)
            }
            
            componentsResult = splitResult
        }
        
        return componentsResult
    }
    
    private static func enqueue(_ calculateItem: String, in formula: inout Formula) {
        if let number: Double = Double(calculateItem) {
            formula.operands.enqueue(number)
        } else {
            if let `operator`: Operator = Operator(rawValue: Character(calculateItem)) {
                formula.operators.enqueue(`operator`)
            }
        }
    }
}
