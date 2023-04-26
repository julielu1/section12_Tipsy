//
//  UIViewWithBorder.swift
//  OneBill
//
//  Created by Julie Lu on 26/4/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//
import UIKit

class UIViewWithBorder: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 2 // Set the border width
        layer.borderColor = UIColor.black.cgColor // Set the border color
        layer.cornerRadius = 5 // Add a corner radius for a rounded border
    }
}
