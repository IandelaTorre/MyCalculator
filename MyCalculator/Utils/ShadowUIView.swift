//
//  ShadowUIStackView.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 28/10/25.
//

import UIKit

extension UIView {
    /// Aplica un efecto hundido (neumórfico suave y moderno)
    func applySunkenEffect(
        cornerRadius: CGFloat = 25,
        baseColor: UIColor = .systemGray4
    ) {
        self.backgroundColor = baseColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        // Elimina sombras anteriores si existían
        self.layer.sublayers?.removeAll(where: { $0.name == "sunkenLayer" })

        // Capa para el efecto de profundidad
        let sunkenLayer = CALayer()
        sunkenLayer.name = "sunkenLayer"
        sunkenLayer.frame = bounds
        sunkenLayer.cornerRadius = cornerRadius
        sunkenLayer.backgroundColor = baseColor.cgColor

        // Crea un degradado que da la sensación de “hueco”
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.cornerRadius = cornerRadius
        gradient.colors = [
            UIColor.white.withAlphaComponent(0.6).cgColor,
            baseColor.cgColor,
            UIColor.black.withAlphaComponent(0.2).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)

        sunkenLayer.addSublayer(gradient)
        self.layer.insertSublayer(sunkenLayer, at: 0)
    }
}
