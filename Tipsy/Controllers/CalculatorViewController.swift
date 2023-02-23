//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipMultiplier = 1.1
    var calculatorBrain = CalculatorBrain()
    var splitPct = 0
    
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
        
        calculatorBrain.calculateCost(billTotal: billTotal, tipMultiplier: tipMultiplier, splitString: splitValue)
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.costFloat = calculatorBrain.returnCost()
            destinationVC.splitPeople = calculatorBrain.returnSplit()
            destinationVC.splitPct = calculatorBrain.returnTip()
        }
    }
}

