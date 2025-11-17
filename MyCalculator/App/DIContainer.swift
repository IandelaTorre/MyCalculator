//
//  DIContainer.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 28/10/25.
//

import Foundation

final class DIContainer {
    func makeCalculatorViewModel() -> CalculatorViewModel {
        let repository: UnitsRepository
        repository = LocalUnitsRepository()
        let getUnits = GetUnitsUseCase(repository: repository)
        let convertUseCase = ConvertUnitUseCase()
        let evaluateExpressionUseCase = EvaluateExpressionUseCase()
        return CalculatorViewModel(convertUnitsUseCase: convertUseCase, fetchUnits: getUnits, evaluateExpressionUseCase: evaluateExpressionUseCase)
    }
}
