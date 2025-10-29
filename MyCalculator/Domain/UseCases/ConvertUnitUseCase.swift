//
//  ConvertUnitUseCase.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 29/10/25.
//

import Foundation

final class ConvertUnitUseCase {
    func execute(amount: Double, from: String, to: String, units: Units) -> Double? {
        guard let uFrom = units.units[from], let uTo = units.units[to] else { return nil }
        let factor = uTo / uFrom
        let result = amount * factor
        return result
    }
}
