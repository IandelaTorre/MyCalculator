//
//  CalculatorViewModel.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 28/10/25.
//

import Foundation
import Combine

class CalculatorViewModel {
    private let convertUnitsUseCase: ConvertUnitUseCase
    private let fetchUnits: GetUnitsUseCase
    private var units: Units?
    private var cancellables = Set<AnyCancellable>()
    
    init(convertUnitsUseCase: ConvertUnitUseCase, fetchUnits: GetUnitsUseCase) {
        self.convertUnitsUseCase = convertUnitsUseCase
        self.fetchUnits = fetchUnits
    }
    
}
