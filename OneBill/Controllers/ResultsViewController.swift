//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Julie Lu on 21/2/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var costFloat: Float?
    var splitPeople: Int?
    var splitPct: Int?
    var baseCurrency: String?
    var quoteCurrency: String?
    var exchangeRate: Float?
    var totalBase: Float?
    var totalQuote: Float?
    
    var pickerData = PickerData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let currencySymbol = pickerData.symbolDictionary[quoteCurrency!]
        
        totalLabel.text = "\(currencySymbol!)" + String(costFloat!)
        settingsLabel.text = "Split between \(splitPeople!) people, with \(splitPct!)% tip"
        
        if baseCurrency! != quoteCurrency! {
            exchangeLabel.text = "1 \(baseCurrency!) → \(exchangeRate!) \(quoteCurrency!)"
            exchangeLabelTotal.text = "\(totalBase!) \(baseCurrency!) → \(totalQuote!) \(quoteCurrency!)"
        } else {
            exchangeLabel.text = ""
            exchangeLabelTotal.text = ""
        }
    }
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var exchangeLabelTotal: UILabel!
    
    
    @IBAction func recalculatePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
