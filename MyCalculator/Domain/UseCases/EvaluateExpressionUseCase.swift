//
//  CalculateExpression.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 17/11/25.
//

import Foundation

final class EvaluateExpressionUseCase {
    func execute(expression: String?) -> Double? {
        guard let raw = expression?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              !raw.isEmpty
        else { return nil }

        let cleaned = raw
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")

        let invalidEndings: Set<Character> = ["+", "-", "*", "/", "."]
        if let last = cleaned.last, invalidEndings.contains(last) {
            return nil
        }

        let pattern = #"^[0-9]+(?:\.[0-9]+)?(?:[+\-*/][0-9]+(?:\.[0-9]+)?)*$"#
        guard cleaned.range(of: pattern, options: .regularExpression) != nil else {
            return nil
        }

        let exp = NSExpression(format: cleaned)
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.doubleValue
        }
        return nil
    }
}

