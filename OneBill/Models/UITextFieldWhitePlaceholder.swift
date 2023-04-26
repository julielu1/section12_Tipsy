//
//  UITextFieldWhitePlaceholder.swift
//  OneBill
//
//  Created by Julie Lu on 26/4/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class UITextFieldWhitePlaceholder: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
    }
    
}
