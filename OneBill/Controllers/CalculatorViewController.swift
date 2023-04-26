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
    @IBOutlet weak var billTextField: UITextFieldWhitePlaceholder!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var basePicker: UIPickerView!
    @IBOutlet weak var quotePicker: UIPickerView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var fetchingdataLabel: UILabel!
    @IBOutlet weak var fetchingdataActivityIndicator: UIActivityIndicatorView!
    
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
            fetchingdataLabel.isHidden = false
            fetchingdataActivityIndicator.startAnimating()
            // Completion handler is being used
            currencyManager.fetchRate(baseCurrency: baseCurrency, quotedCurrency: quoteCurrency) {rate in
                self.calculatedRate = rate
                // Perform calculations and segues
                self.calculatorBrain.calculateCost(billTotal: billTotal, tipMultiplier: self.tipMultiplier, splitString: splitValue, exchangeRate: self.calculatedRate, base: self.baseCurrency, quote: self.quoteCurrency)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToResult", sender: self)
                    self.fetchingdataLabel.isHidden = true
                    self.fetchingdataActivityIndicator.stopAnimating()
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == basePicker {
            baseCurrency = pickerData.currencyOnly[row]
        }
        else if pickerView == quotePicker {
            quoteCurrency = pickerData.currencyOnly[row]
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData: String
        if pickerView == basePicker || pickerView == quotePicker {
            titleData =  pickerBaseData[row]
        }
        else {
            titleData = "NULL"
        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return myTitle
    }

    // Ignore / testing
    @IBAction func extraPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToExtras", sender: self)
    }
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    
        stepper.minimumValue = 1
        
        fetchingdataLabel.isHidden = true
        
        // Delegates
        self.basePicker.delegate = self
        self.basePicker.dataSource = self
        
        self.quotePicker.delegate = self
        self.quotePicker.dataSource = self
        
        currencyManager.delegate = self
        
        // Data
        
        pickerBaseData = pickerData.fullData
        pickerQuoteData = pickerBaseData
        
        
        basePicker.selectRow(1, inComponent: 0, animated: false)
        quotePicker.selectRow(1, inComponent: 0, animated: false)
        
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
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

