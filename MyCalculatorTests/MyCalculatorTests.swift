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

    // MARK: - Unit conversion

        func test_convertUnits_mToCm_calculatedAmount() {
            let result = useCase.execute(amount: 150, from: "m", to: "cm", units: units)
            XCTAssertEqual(result, 15000.0)
        }

        func test_convertUnits_cmToM_calculatedAmount() {
            let result = useCase.execute(amount: 250, from: "cm", to: "m", units: units)
            XCTAssertEqual(result, 2.5)
        }

        func test_convertUnits_mToMm_calculatedAmount() {
            let result = useCase.execute(amount: 1.5, from: "m", to: "mm", units: units)
            XCTAssertEqual(result, 1500.0)
        }

        func test_convertUnits_kmToM_calculatedAmount() {
            let result = useCase.execute(amount: 3.0, from: "km", to: "m", units: units)
            XCTAssertEqual(result, 3000.0)
        }

        func test_convertUnits_ftToIn_calculatedAmount() {
            let result = useCase.execute(amount: 2.0, from: "ft", to: "in", units: units)
            // 1 ft = 3.28084^-1 m, 1 in = 39.3701 m ⇒ 2 ft → 24 in aprox
            XCTAssertEqual(result!, 24.0, accuracy: 0.001)
        }

        func test_convertUnits_invalidFromUnit_returnsNil() {
            let result = useCase.execute(amount: 10.0, from: "XXX", to: "m", units: units)
            XCTAssertNil(result)
        }

        func test_convertUnits_invalidToUnit_returnsNil() {
            let result = useCase.execute(amount: 10.0, from: "m", to: "XXX", units: units)
            XCTAssertNil(result)
        }

        func test_convertUnits_sameUnit_returnsSameValue() {
            let result = useCase.execute(amount: 123.45, from: "m", to: "m", units: units)
            XCTAssertEqual(result, 123.45)
        }

        // MARK: - Expression evaluation

        func test_calculateExpression_3Plus2_result() {
            let result = evaluateExpression.execute(expression: "3+2")
            XCTAssertEqual(result, 5.0)
        }

        func test_calculateExpression_10Minus4_result() {
            let result = evaluateExpression.execute(expression: "10-4")
            XCTAssertEqual(result, 6.0)
        }

        func test_calculateExpression_6Times7_result() {
            let result = evaluateExpression.execute(expression: "6*7")
            XCTAssertEqual(result, 42.0)
        }

        func test_calculateExpression_20DividedBy5_result() {
            let result = evaluateExpression.execute(expression: "20/5")
            XCTAssertEqual(result, 4.0)
        }

        func test_calculateExpression_mixedOperators_respectsPrecedence() {
            let result = evaluateExpression.execute(expression: "2+3*4")
            XCTAssertEqual(result, 14.0)
        }

        func test_calculateExpression_mixedOperatorsWithSubtraction_respectsPrecedence() {
            let result = evaluateExpression.execute(expression: "10-3*2")
            XCTAssertEqual(result, 4.0)
        }

        func test_calculateExpression_negativeResult_returnsNegativeValue() {
            let result = evaluateExpression.execute(expression: "5-10")
            XCTAssertEqual(result, -5.0)
        }

        func test_calculateExpression_decimalValues_result() {
            let result = evaluateExpression.execute(expression: "1.5+2.25")
            XCTAssertEqual(result!, 3.75, accuracy: 0.0001)
        }

        func test_calculateExpression_invalidExpression_returnsNil() {
            let result = evaluateExpression.execute(expression: "3+*2")
            XCTAssertNil(result)
        }
    
    

}
