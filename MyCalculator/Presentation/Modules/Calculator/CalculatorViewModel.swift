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
    @Published var typeCalculator: Mode = .calculator
    @Published var fromUnits: String? = "From"
    @Published var toUnits: String? = "To"
    
    @Published private(set) var result: String? = "0"
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var availableUnits: [String] = []
    @Published private(set) var errorMessage: String?
    
    private let convertUnitsUseCase: ConvertUnitUseCase
    private let fetchUnits: GetUnitsUseCase
    private let evaluateExpressionuseCase: EvaluateExpressionUseCase
    private var units: Units?
    private var cancellables = Set<AnyCancellable>()
    
    init(convertUnitsUseCase: ConvertUnitUseCase, fetchUnits: GetUnitsUseCase, evaluateExpressionUseCase: EvaluateExpressionUseCase) {
        self.convertUnitsUseCase = convertUnitsUseCase
        self.fetchUnits = fetchUnits
        self.evaluateExpressionuseCase = evaluateExpressionUseCase
        
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
    
    func selectCurrency(code: String, forFrom: Bool) {
            if forFrom { fromUnits = code } else { toUnits = code }
        }
    
    private func performCalculator(expressionStr: String?, typeC: Mode, from: String, to: String) {
        guard let units = self.units else {
            self.result = nil
            return
        }
        switch typeC {
        case .calculator:
            if let evaluated = evaluateExpressionuseCase.execute(expression: expressionStr ?? "") {
                self.result = String(evaluated)
            }
            
        case .converter:
            if let converted = convertUnitsUseCase.execute(amount: Double(expressionStr ?? "") ?? 0.0, from: from, to: to, units: units) {
                self.result = String(converted)
            }
        }
    }
    
}
