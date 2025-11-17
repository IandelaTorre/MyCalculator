//
//  MyCalculatorTests.swift
//  MyCalculatorTests
//
//  Created by Ian Axel Perez de la Torre on 22/10/25.
//

import XCTest
@testable import MyCalculator

final class MyCalculatorTests: XCTestCase {

    var useCase: ConvertUnitUseCase!
    var evaluateExpression: EvaluateExpressionUseCase!
    let units = Units(base: "m", units: [ "m": 1.0, "cm": 100.0, "mm": 1000.0, "km": 0.001, "in": 39.3701, "ft": 3.28084, "yd": 1.09361])

    override func setUp() {
        super.setUp()
        useCase = ConvertUnitUseCase()
        evaluateExpression = EvaluateExpressionUseCase()
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func test_convertUnits_mToCm_calculatedAmount() {
        let result = useCase.execute(amount: 150, from: "m", to: "cm", units: units)
        XCTAssertEqual(result, 15000.0)
    }
    
    func test_calculateExpression_3Plus2_result() {
        let result = evaluateExpression.execute(expression: "3+2")
        XCTAssertEqual(result, 5.0)
    }
    
    

}
