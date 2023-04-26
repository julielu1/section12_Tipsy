//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // IBOutlets
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var basePicker: UIPickerView!
    @IBOutlet weak var quotePicker: UIPickerView!
    
    // Variables
    var tipMultiplier = 1.0
    var calculatorBrain = CalculatorBrain()
    var splitPct = 0
    var baseCurrency = "AUD"
    var quoteCurrency = "AUD"
    var pickerBaseData: [String] = [String]()
    var pickerQuoteData: [String] = [String]()
    var currencyManager = CurrencyManager()
    var calculatedRate: Float = 0
    var pickerData = PickerData()
    
    // IBActions
    @IBAction func tipChanged(_ sender: UIButton) {
        switch sender.currentTitle! {
        case "0%":
            tipMultiplier = 1.0
            splitPct = 0
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        case "10%":
            tipMultiplier = 1.10
            splitPct = 10
            tenPctButton.isSelected = true
            zeroPctButton.isSelected = false
            twentyPctButton.isSelected = false
        case "20%":
            tipMultiplier = 1.20
            splitPct = 20
            twentyPctButton.isSelected = true
            tenPctButton.isSelected = false
            zeroPctButton.isSelected = false
        default:
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        }
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let valueInt = Int(sender.value)
        let valueStr = String(valueInt)
        splitNumberLabel.text = valueStr
    }
    
    @IBAction func calculatePressed(_ sender: Any) {

        let billTotal = billTextField.text
        let splitValue = splitNumberLabel.text
        
        if baseCurrency == quoteCurrency {
            self.calculatedRate = 1
            calculatorBrain.calculateCost(billTotal: billTotal, tipMultiplier: self.tipMultiplier, splitString: splitValue, exchangeRate: self.calculatedRate, base: baseCurrency, quote: quoteCurrency)
            performSegue(withIdentifier: "goToResult", sender: self)
        } else {
            // Completion handler is being used
            currencyManager.fetchRate(baseCurrency: baseCurrency, quotedCurrency: quoteCurrency) {rate in
                self.calculatedRate = rate
                
                // Perform calculations and segues
                self.calculatorBrain.calculateCost(billTotal: billTotal, tipMultiplier: self.tipMultiplier, splitString: splitValue, exchangeRate: self.calculatedRate, base: self.baseCurrency, quote: self.quoteCurrency)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToResult", sender: self)
                }
            }
        }
    }
    
    // Base picker functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == basePicker || pickerView == quotePicker {
            return pickerBaseData.count }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == basePicker || pickerView == quotePicker {
            return pickerBaseData[row]
        }
        else {
            return "NULL"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == basePicker {
            baseCurrency = pickerData.currencyOnly[row]
        }
        else if pickerView == quotePicker {
            quoteCurrency = pickerData.currencyOnly[row]
        }

    }

    // Ignore / testing
    @IBAction func extraPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToExtras", sender: self)
    }
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        self.basePicker.delegate = self
        self.basePicker.dataSource = self
        
        self.quotePicker.delegate = self
        self.quotePicker.dataSource = self
        
        currencyManager.delegate = self
        
        pickerBaseData = pickerData.fullData
        pickerQuoteData = pickerBaseData
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.costFloat = calculatorBrain.returnCost()
            destinationVC.splitPeople = calculatorBrain.returnSplit()
            destinationVC.splitPct = calculatorBrain.returnTip()
            destinationVC.baseCurrency = calculatorBrain.returnBaseCurrency()
            destinationVC.quoteCurrency = calculatorBrain.returnQuoteCurrency()
            destinationVC.exchangeRate = calculatorBrain.returnRate()
            destinationVC.totalBase = calculatorBrain.returnTotalBase()
            destinationVC.totalQuote = calculatorBrain.returnTotalQuote()
        }
        
//        else if segue.identifier == "goToExtras" {
//            segue.destination as! ExtrasViewController
//        }
    }
    

}

extension CalculatorViewController: CurrencyManagerDelegate {
    func didFetchRate(_ currencyManager: CurrencyManager, currency: CurrencyModel) {
        self.calculatedRate = currency.rate
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}
