//
//  ShadowButton.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 22/10/25.
//

import UIKit

extension UIButton {
    
    /// Aplica el estilo neumórfico (ligeramente sobresalido) al botón.
    /// - Parameters:
    ///   - lightColor: Color de la luz (para el borde superior izquierdo)
    ///   - darkColor: Color de la sombra (para el borde inferior derecho)
    ///   - background: Color de fondo del botón
    ///   - cornerRadius: Radio de redondeo (por defecto 40)
    ///   - isDarkMode: Si `true`, invierte la dirección de la luz/sombra
    func applyNeumorphicStyle(
        lightColor: UIColor,
        darkColor: UIColor,
        background: UIColor,
        cornerRadius: CGFloat = 40,
        isDarkMode: Bool = false
    ) {
        // Fondo
        self.backgroundColor = background
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        // Limpia sombras previas
        self.layer.sublayers?.removeAll(where: { $0.name == "neumorphicShadow" })
        
        // Capas de sombra
        let shadowLayer = CALayer()
        shadowLayer.name = "neumorphicShadow"
        shadowLayer.frame = bounds
        shadowLayer.cornerRadius = cornerRadius
        
        // Configuración de luces/sombras
        let topLeftColor = isDarkMode ? darkColor.cgColor : lightColor.cgColor
        let bottomRightColor = isDarkMode ? lightColor.cgColor : darkColor.cgColor
        
        // Sombra superior izquierda (luz)
        let lightShadow = CALayer()
        lightShadow.frame = bounds
        lightShadow.backgroundColor = background.cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowColor = topLeftColor
        lightShadow.shadowOffset = CGSize(width: -3, height: -3)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 3
        
        // Sombra inferior derecha (oscura)
        let darkShadow = CALayer()
        darkShadow.frame = bounds
        darkShadow.backgroundColor = background.cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowColor = bottomRightColor
        darkShadow.shadowOffset = CGSize(width: 3, height: 3)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 3
        
        shadowLayer.addSublayer(lightShadow)
        shadowLayer.addSublayer(darkShadow)
        
        // Inserta las sombras detrás del contenido
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    /// Variante para cuando el botón está presionado (efecto invertido)
    func applyPressedNeumorphicEffect() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            self.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    
    /// Restaura el estado normal del botón después de presionar
    func removePressedNeumorphicEffect() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.layer.shadowOffset = CGSize(width: 3, height: 3)
        }
    }
}
