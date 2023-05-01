//
//  RoundedView.swift
//  OneBill
//
//  Created by Julie Lu on 1/5/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

import UIKit

class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the corner radius to half of the view's height
        layer.cornerRadius = bounds.height / 4
        
        // Clips to bounds to ensure the corners are rounded
        clipsToBounds = true
    }
}

