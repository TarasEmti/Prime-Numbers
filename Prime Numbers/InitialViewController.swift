//
//  ViewController.swift
//  Prime Numbers
//
//  Created by Тарас on 29.05.17.
//  Copyright © 2017 Taras Minin. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberInputTextField: UITextField!
    
    @IBOutlet weak var isPrimeLabel: UILabel!
    @IBOutlet weak var primeNumbersSummLabel: UILabel!
    @IBOutlet weak var primeNumbersList: UITextView!
    
    let stats = PrimeNumbersStats()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCustomisation()
        changeViewStats()
        
        numberInputTextField.delegate = self
    }
    
    func viewCustomisation() {
        
        isPrimeLabel.text = "-"
        isPrimeLabel.textColor = .gray
        
        primeNumbersSummLabel.textColor = .gray
        
        primeNumbersList.textColor = .gray
        primeNumbersList.textAlignment = .right
        primeNumbersList.textContainer.lineFragmentPadding = 0.0
        primeNumbersList.contentInset = .zero
        
        let clearDataButton = UIBarButtonItem(title: "Clear Data", style: .plain, target: self, action: #selector(clearStats))
        self.navigationItem.rightBarButtonItem = clearDataButton
    }
    
    @IBAction func checkNumber(_ sender: Any) {
        
        guard let numberString = numberInputTextField.text,
            let number = Int64(numberString) else {
                
                showErrorAlert(error: "This number is too big (Int64 limits)")
                return
        }
        
        if PrimeNumberValidate.isPrimeNumber(number) {
            
            stats.addNewPrimeNumber(number)
            showValidationSuccsess(isPrime: true)
            changeViewStats()
            
        } else {
            showValidationSuccsess(isPrime: false)
        }
        clearNumberField(isError: false)
    }
    
    func showValidationSuccsess(isPrime: Bool) {
        
        if isPrime {
            
            isPrimeLabel.text = "YES"
            isPrimeLabel.textColor = .green
            
        } else {
            
            isPrimeLabel.text = "NO"
            isPrimeLabel.textColor = .red
        }
    }
    
    func changeViewStats() {
        
        primeNumbersSummLabel.text = "\(stats.getSumm())"
        primeNumbersList.text = stats.getList()
    }
    
    func clearNumberField(isError: Bool) {
        
        numberInputTextField.text = ""
        
        if isError {
            isPrimeLabel.text = "-"
            isPrimeLabel.textColor = .gray
        }
    }
    
    func clearStats() {
        
        stats.clear()
        clearNumberField(isError: true)
        changeViewStats()
    }
    
    func showErrorAlert(error: String) {
        
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert
        )
        
        self.present(alert, animated: true, completion: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                alert.dismiss(animated: true, completion: {
                    self.clearNumberField(isError: true)
                })
            })
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.trimmingCharacters(in: CharacterSet.decimalDigits).isEmpty {
            
            //Запрет на вставку числа, начинающегося с нуля, в пустое или нулевое поле
            if string.hasPrefix("0") && string.characters.count > 1 &&
                (textField.text! == "0" || textField.text! == "") {
                return false
            }
            
            //Если первая цифра 0, то последующее число его сотрет 
            if textField.text! == "0" {
                textField.text = ""
            }
            return true
        }
        return false
    }
}

