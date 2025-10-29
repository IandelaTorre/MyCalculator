//
//  UnitsRepository.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 29/10/25.
//

import Foundation

protocol UnitsRepository {
    func fetchUnits() async throws -> Units 
}
