//
//  ViewController.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 22/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var number0Button: UIButton!
    @IBOutlet weak var number1Button: UIButton!
    @IBOutlet weak var number2Button: UIButton!
    @IBOutlet weak var number3Button: UIButton!
    @IBOutlet weak var number4Button: UIButton!
    @IBOutlet weak var number5Button: UIButton!
    @IBOutlet weak var number6Button: UIButton!
    @IBOutlet weak var number7Button: UIButton!
    @IBOutlet weak var number8Button: UIButton!
    @IBOutlet weak var number9Button: UIButton!
    
    @IBOutlet weak var ACButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var backspaceButton: UIButton!
    @IBOutlet weak var subtractionButton: UIButton!
    @IBOutlet weak var additionButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var porcentageButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundColor = UIColor(named: "MyCalculatorBackground") ?? .systemGray6
        let light = UIColor.white.withAlphaComponent(0.8)
        let dark = UIColor.black.withAlphaComponent(0.2)
            
            [number0Button, number1Button, number2Button, number3Button, number4Button, number5Button, number6Button, number7Button,number8Button,  number9Button].forEach { button in
                button?.applyNeumorphicStyle(
                    lightColor: light,
                    darkColor: dark,
                    background: backgroundColor,
                    isDarkMode: false
                )
            }
        
        [ACButton, divisionButton, multiplicationButton, backspaceButton, subtractionButton, additionButton, equalButton, porcentageButton, decimalButton].forEach { button in
            button?.applyNeumorphicStyle(
                lightColor: dark,
                darkColor: light,
                background: backgroundColor,
                isDarkMode: false
                )
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTouchDown(_ sender: UIButton) {
        sender.applyPressedNeumorphicEffect()
    }

    @IBAction func buttonTouchUp(_ sender: UIButton) {
        sender.removePressedNeumorphicEffect()
    }



    @IBAction func ACButtonAction(_ sender: UIButton) {
    }
    @IBAction func DivisionButtonAction(_ sender: UIButton) {
    }
    @IBAction func MultiplicationButtonAction(_ sender: UIButton) {
    }
    @IBAction func BackspaceButtonAction(_ sender: UIButton) {
    }
    @IBAction func SubtractionButtonAction(_ sender: UIButton) {
    }
    @IBAction func AdditionButtonAction(_ sender: UIButton) {
    }
    @IBAction func EqualButtonAction(_ sender: UIButton) {
    }
    @IBAction func PorcentageButtonAction(_ sender: UIButton) {
    }
    @IBAction func DecimalButtonAction(_ sender: UIButton) {
    }
    @IBAction func NumberButtonAction(_ sender: UIButton) {
    }
}

