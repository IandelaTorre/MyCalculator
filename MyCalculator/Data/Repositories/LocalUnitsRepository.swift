//
//  LocalRatesRepository.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 29/10/25.
//

import Foundation

final class LocalUnitsRepository: UnitsRepository {
    func fetchUnits() async throws -> Units {
        let map: [String: Double] = [
                    "m": 1.0,           // base
                    "cm": 100.0,        // 1 m = 100 cm
                    "mm": 1000.0,       // 1 m = 1000 mm
                    "km": 0.001,        // 1 m = 0.001 km
                    "in": 39.3701,      // 1 m = 39.37 pulgadas
                    "ft": 3.28084,      // 1 m = 3.28 pies
                    "yd": 1.09361       // 1 m = 1.09 yardas
                ]
        return Units(base: "m", units: map)
    }
}
