//
//  ViewController.swift
//  MyCalculator
//
//  Created by Ian Axel Perez de la Torre on 22/10/25.
//

import UIKit
import Combine

class CalculatorViewController: UIViewController {
    
    var viewModel: CalculatorViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    required init?(coder: NSCoder) {
                super.init(coder: coder)
            }
    
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
    
    @IBOutlet weak var labelsUIView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    let operations: Dictionary<Int,String> = [-1:"/", -2:"*", -3:"-",-4:"+"]
    var isAcActive: Bool = true
    let decimalSeparator = Locale.current.decimalSeparator ?? "."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelsUIView.layer.cornerRadius = 20
        labelsUIView.layer.borderWidth = 1
        labelsUIView.layer.borderColor = UIColor.black.cgColor
        labelsUIView.clipsToBounds = true
        
        resultLabel.text = "0"
        totalLabel.text = "0"
        ACButton.setTitle("AC", for: .normal)
        decimalButton.setTitle(decimalSeparator, for: .normal)

        
        let backgroundColor = UIColor(named: "MyCalculatorBackground") ?? .systemGray6
        let light = UIColor.white.withAlphaComponent(0.8)
        let dark = UIColor.black.withAlphaComponent(0.2)
            
            [number0Button, number1Button, number2Button, number3Button, number4Button, number5Button, number6Button, number7Button,number8Button,  number9Button,ACButton, divisionButton, multiplicationButton, backspaceButton, subtractionButton, additionButton, porcentageButton, decimalButton].forEach { button in
                button?.applyNeumorphicStyle(
                    lightColor: light,
                    darkColor: dark,
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
        if isAcActive {
            resultLabel.text = "0"
            totalLabel.text = "0"
        } else {
            resultLabel.text = "0"
            ACButton.setTitle("AC", for: .normal)
        }
        
    }
    @IBAction func BackspaceButtonAction(_ sender: UIButton) {
        if let text = resultLabel.text, !text.isEmpty {
            resultLabel.text = String(text.dropLast())
            ACButton.setTitle("C", for: .normal)
            isAcActive = false
        } else {
            ACButton.setTitle("AC", for: .normal)
            isAcActive = true
        }
    }
    @IBAction func EqualButtonAction(_ sender: UIButton) {
        totalLabel.text = resultLabel.text
        resultLabel.text = "0"
        ACButton.setTitle("AC", for: .normal)
        isAcActive = true
    }
    @IBAction func PorcentageButtonAction(_ sender: UIButton) {
    }
    @IBAction func DecimalButtonAction(_ sender: UIButton) {
    }
    @IBAction func NumberButtonAction(_ sender: UIButton) {
        print(sender.tag)
        if sender.tag < 0 {
            resultLabel.text! += operations[sender.tag] ?? ""
        } else {
            resultLabel.text! += String(sender.tag)
        }
        ACButton.setTitle("C", for: .normal)
        isAcActive = false
    }
}

