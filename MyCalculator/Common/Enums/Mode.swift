//
//  Mode.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 16/11/25.
//

import Foundation

enum Mode: Int {
    case calculator = 0
    case converter = 1

    var title: String {
        switch self {
        case .calculator: return "Calculadora"
        case .converter: return "Conversor"
        }
    }

    var isCalculator: Bool {
        self == .calculator
    }

    var isConverter: Bool {
        self == .converter
    }
}
