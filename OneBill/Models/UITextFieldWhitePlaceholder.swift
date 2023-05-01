//
//  UITextFieldWhitePlaceholder.swift
//  OneBill
//
//  Created by Julie Lu on 26/4/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class UITextFieldWhitePlaceholder: UITextField {
    
//    var dollarSignAdded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
        
//        addTarget(self, action: #selector(dollarSignDidChange(_:)), for: .editingChanged)
    }
//
//    @objc private func dollarSignDidChange(_ textField: UITextField) {
//        if let text = textField.text, !text.isEmpty {
//            if !dollarSignAdded {
//                textField.text = "$" + text
//                dollarSignAdded = true
//            } else {
//                dollarSignAdded = false
//            }
//        }
//    }
}

//let currencySymbol = pickerData.symbolDictionary[pickerData.currencyOnly[row]]
//let billText = billTextField.text
//let numberString = billText!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//print(numberString)
//print(currencySymbol!)
//billTextField.text = "\(currencySymbol!)\(numberString)"
