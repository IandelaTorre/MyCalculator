//
//  CalculatorViewModel.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 28/10/25.
//

import Foundation
import Combine

class CalculatorViewModel {
    
    @Published var expression: String? = "0"
    @Published var typeCalculator: Bool = true
    @Published var fromUnits: String? = "From"
    @Published var toUnits: String? = "To"
    
    @Published private(set) var result: String? = "0"
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var availableUnits: [String] = []
    @Published private(set) var errorMessage: String?
    
    private let convertUnitsUseCase: ConvertUnitUseCase
    private let fetchUnits: GetUnitsUseCase
    private var units: Units?
    private var cancellables = Set<AnyCancellable>()
    
    init(convertUnitsUseCase: ConvertUnitUseCase, fetchUnits: GetUnitsUseCase) {
        self.convertUnitsUseCase = convertUnitsUseCase
        self.fetchUnits = fetchUnits
        
        Publishers.CombineLatest4($expression, $typeCalculator, $fromUnits, $toUnits)
                    .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
                    .sink { [weak self] amountStr, typeC, from, to in
                        self?.performCalculator(expressionStr: amountStr ?? "", typeC: typeC, from: from ?? "", to: to ?? "")
                    }
                    .store(in: &cancellables)
    }
    
    func loadUnits() {
        isLoading = true
        Task {
            do {
                let fetchedUnits = try await fetchUnits.execute()
                self.units = fetchedUnits
                self.availableUnits = Array(fetchedUnits.units.keys).sorted()
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    private func performCalculator(expressionStr: String?, typeC: Bool, from: String, to: String) {
        guard let units = self.units else {
            self.result = nil
            return
        }
        if (typeC) {
            if let evaluated = evaluateExpression(expressionStr ?? "0") {
                self.result = String(evaluated)
            }
        }
        else {
            if let converted = convertUnitsUseCase.execute(amount: Double(expressionStr ?? "") ?? 0.0, from: from, to: to, units: units) {
                self.result = String(converted)
            }
        }
        
    }
    
    
    private func evaluateExpression(_ expression: String?) -> Double? {
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
