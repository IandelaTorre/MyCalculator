//
//  CalculateExpression.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 17/11/25.
//

import Foundation

final class EvaluateExpressionUseCase {
    func execute(expression: String?) -> Double? {
            guard let raw = expression?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !raw.isEmpty else { return nil }

            let invalidEndings: Set<Character> = ["+", "-", "*", "/", "."]
            if let last = raw.last, invalidEndings.contains(last) {
                return nil
            }

            let sanitized = raw
                .replacingOccurrences(of: "×", with: "*")
                .replacingOccurrences(of: "÷", with: "/")

            let exp = NSExpression(format: sanitized)
            if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
                return result.doubleValue
            }
            return nil
    }
}
