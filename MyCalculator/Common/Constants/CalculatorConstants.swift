//
//  CalculatorConstants.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 16/11/25.
//

import Foundation

enum CalculatorConstants {
    static let operations: Dictionary<Int,String> = [ -1: "/", -2: "*", -3: "-", -4: "+", -5: "(", -6: ")" ]
    static let decimalSeparator = Locale.current.decimalSeparator ?? "."
}
