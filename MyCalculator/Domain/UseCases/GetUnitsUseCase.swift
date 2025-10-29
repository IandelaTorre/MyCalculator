//
//  GetUnitsUseCaes.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 29/10/25.
//

import Foundation

final class GetUnitsUseCase {
    private let repository: UnitsRepository
    init(repository: UnitsRepository) {
        self.repository = repository
    }
    func execute() async throws -> Units {
        return try await repository.fetchUnits()
    }
}
