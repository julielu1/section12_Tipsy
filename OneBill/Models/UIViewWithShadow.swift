//
//  UIViewWithShadow.swift
//  OneBill
//
//  Created by Julie Lu on 27/4/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

import UIKit
class UIViewWithShadow: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
    }
    
}
