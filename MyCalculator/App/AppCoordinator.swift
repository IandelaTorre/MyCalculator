//
//  AppCoordinator.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 28/10/25.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let diContainer: DIContainer

    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
    }

    @MainActor func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let calculatorVC = storyboard.instantiateViewController(
            withIdentifier: "CalculatorViewController"
        ) as? CalculatorViewController else {
            fatalError("No se encontró ConverterViewController en el Storyboard")
        }

        calculatorVC.viewModel = diContainer.makeCalculatorViewModel()

        let navigation = UINavigationController(rootViewController: calculatorVC)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
