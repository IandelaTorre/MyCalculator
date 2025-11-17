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
    
   
    @IBOutlet weak var fromUnitButton: UIButton!
    @IBOutlet weak var toUnitButton: UIButton!
    
    
    @IBOutlet weak var labelsUIView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var conversionSectionStackView: UIStackView!
    @IBOutlet weak var typeCalculatorSegmentedControl: UISegmentedControl!
    
    var isAcActive: Bool = true
    
    var typeCalculator: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelsUIView.layer.cornerRadius = 20
        labelsUIView.layer.borderWidth = 1
        labelsUIView.layer.borderColor = UIColor.black.cgColor
        labelsUIView.clipsToBounds = true
        conversionSectionStackView.isHidden = true
        
        resultLabel.text = ""
        totalLabel.text = ""
        ACButton.setTitle("AC", for: .normal)
        decimalButton.setTitle(CalculatorConstants.decimalSeparator, for: .normal)
        bind()
        viewModel.loadUnits()

    }
    
    private func bind() {
        
        typeCalculatorSegmentedControl.addTarget(self, action: #selector(modeChanged(_:)), for: .valueChanged)
        fromUnitButton.addTarget(self, action: #selector(fromTapped), for: .touchUpInside)
        toUnitButton.addTarget(self, action: #selector(toTapped), for: .touchUpInside)
        
        viewModel.$result
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                self?.totalLabel.text = result ?? "-"
                
            }
            .store(in: &cancellables)
        
        viewModel.$typeCalculator
            .receive(on: RunLoop.main)
            .sink { [weak self] type in
                self?.typeCalculator = type.rawValue
            }
            .store(in: &cancellables)
        
        viewModel.$fromUnits
            .receive(on: RunLoop.main)
            .sink { [weak self] from in
                self?.fromUnitButton.setTitle(from, for: .normal)
            }
            .store(in: &cancellables)
        
        viewModel.$toUnits
            .receive(on: RunLoop.main)
            .sink { [weak self] to in
                self?.toUnitButton.setTitle(to, for: .normal)
            }
            .store(in: &cancellables)
        
    }


    @IBAction func ACButtonAction(_ sender: UIButton) {
        if isAcActive {
            totalLabel.text = ""
        } else {
            resultLabel.text = ""
            viewModel.expression = ""
            ACButton.setTitle("AC", for: .normal)
            isAcActive = true
        }
    }
    
    @IBAction func BackspaceButtonAction(_ sender: UIButton) {
        if let text = resultLabel.text, !text.isEmpty {
            resultLabel.text = String(text.dropLast())
            viewModel.expression = String(text.dropLast())
            ACButton.setTitle("C", for: .normal)
            isAcActive = false
        } else {
            ACButton.setTitle("AC", for: .normal)
            isAcActive = true
        }
    }
    
    @IBAction func EqualButtonAction(_ sender: UIButton) {
        resultLabel.text! = ""
        viewModel.expression = ""
        ACButton.setTitle("AC", for: .normal)
        isAcActive = true
    }
    
    @IBAction func PorcentageButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func DecimalButtonAction(_ sender: UIButton) {
        updateExpression(newValue: ".")
    }
    
    @IBAction func NumberButtonAction(_ sender: UIButton) {
        updateExpression(newValue: sender.tag < 0 ? CalculatorConstants.operations[sender.tag]! : String(sender.tag))
        ACButton.setTitle("C", for: .normal)
        isAcActive = false
    }
    
    private func updateExpression(newValue: String) {
        resultLabel.text! += newValue
        viewModel.expression = resultLabel.text
    }
    
    private func presentUnitSelector(forFrom: Bool) {
        let codes = viewModel.availableUnits
        let alert = UIAlertController(title: "Selecciona una unidad", message: nil, preferredStyle: .actionSheet)
        codes.forEach { code in
            alert.addAction(UIAlertAction(title: code, style: .default) { [weak self] _ in
                self?.viewModel.selectCurrency(code: code, forFrom: forFrom)
            })
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func fromTapped() {
        presentUnitSelector(forFrom: true)
    }
    
    @objc func toTapped() {
        presentUnitSelector(forFrom: false)
    }
    
    @objc func modeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            conversionSectionStackView.isHidden = true
            viewModel.typeCalculator = Mode(rawValue: 0)!
        case 1:
            conversionSectionStackView.isHidden = false
            viewModel.typeCalculator = Mode(rawValue: 1)!
        default:
            return
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let backgroundColor = UIColor(named: "MyCalculatorBackground") ?? .systemGray6
        let light = UIColor.white.withAlphaComponent(0.8)
        let dark = UIColor.black.withAlphaComponent(0.2)

        let buttons = [
            number0Button, number1Button, number2Button, number3Button,
            number4Button, number5Button, number6Button, number7Button,
            number8Button, number9Button, ACButton, divisionButton,
            multiplicationButton, backspaceButton, subtractionButton,
            additionButton, porcentageButton, decimalButton
        ]

        buttons.forEach { button in
            button?.applyNeumorphicStyle(
                lightColor: light,
                darkColor: dark,
                background: backgroundColor,
                isDarkMode: false
            )
        }
    }

    
}

