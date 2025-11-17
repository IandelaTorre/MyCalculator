//
//  ShadowButton.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 22/10/25.
//

import UIKit

extension UIButton {
    func applyNeumorphicStyle(
        lightColor: UIColor,
        darkColor: UIColor,
        background: UIColor,
        cornerRadius: CGFloat? = nil,
        isDarkMode: Bool = false
    ) {
        let radius = cornerRadius ?? min(bounds.width, bounds.height) / 2

        // Fondo
        self.backgroundColor = background
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false

        // Limpia sombras previas
        self.layer.sublayers?.removeAll(where: { $0.name == "neumorphicShadow" })

        // Capas de sombra
        let shadowLayer = CALayer()
        shadowLayer.name = "neumorphicShadow"
        shadowLayer.frame = bounds
        shadowLayer.cornerRadius = radius

        let topLeftColor = isDarkMode ? darkColor.cgColor : lightColor.cgColor
        let bottomRightColor = isDarkMode ? lightColor.cgColor : darkColor.cgColor

        let lightShadow = CALayer()
        lightShadow.frame = bounds
        lightShadow.backgroundColor = background.cgColor
        lightShadow.cornerRadius = radius
        lightShadow.shadowColor = topLeftColor
        lightShadow.shadowOffset = CGSize(width: -3, height: -3)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 3

        let darkShadow = CALayer()
        darkShadow.frame = bounds
        darkShadow.backgroundColor = background.cgColor
        darkShadow.cornerRadius = radius
        darkShadow.shadowColor = bottomRightColor
        darkShadow.shadowOffset = CGSize(width: 3, height: 3)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 3

        shadowLayer.addSublayer(lightShadow)
        shadowLayer.addSublayer(darkShadow)

        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
