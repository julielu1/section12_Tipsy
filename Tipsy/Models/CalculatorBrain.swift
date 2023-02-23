//
//  CalculatorBrain.swift
//  Tipsy
//
//  Created by Julie Lu on 21/2/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    var split: Split?
    mutating func calculateCost (billTotal: String?, tipMultiplier: Double, splitString: String?) {
        let billTotalFloat = Float(billTotal!)
        let tipMultiplier = Float(tipMultiplier)
        let tipPct = Int((tipMultiplier - 1)*100)
        let splitFloat = Float(splitString!)
        
        let costFloat = ((billTotalFloat ?? 0.0) * tipMultiplier) / splitFloat!
        split = Split(costPerPerson: costFloat, splitPeople: Int(splitFloat!), splitPct: tipPct)
    }
    
    func returnCost () -> Float {
        return split?.costPerPerson ?? 0.0
    }
    
    func returnSplit () -> Int {
        return split?.splitPeople ?? 0
    }
    
    func returnTip () -> Int {
        return split?.splitPct ?? 0
    }
}
