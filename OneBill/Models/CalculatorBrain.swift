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
    mutating func calculateCost (billTotal: String?, tipMultiplier: Double, splitString: String?, exchangeRate: Float, base: String, quote: String) {
        let exchangeRateRounded = round(exchangeRate * 100)/100
        let billTotalFloat = Float(billTotal!)
        let tipMultiplier = Float(tipMultiplier)
        let tipPct = Int((tipMultiplier - 1)*100)
        let splitFloat = Float(splitString!)
        
        let costFloat = (((billTotalFloat ?? 0.0) * tipMultiplier) / splitFloat!) * exchangeRateRounded
        let costFloatRounded = round(costFloat * 100)/100
//        split = Split(costPerPerson: costFloatRounded, splitPeople: Int(splitFloat!), splitPct: tipPct)
        split = Split(costPerPerson: costFloatRounded, splitPeople: Int(splitFloat!), splitPct: tipPct, baseCurrency: base, quoteCurrency: quote, exchangeRate: exchangeRateRounded)
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
    
    func returnBaseCurrency () -> String {
        return split?.baseCurrency ?? "NA"
    }
    
    func returnQuoteCurrency () -> String {
        return split?.quoteCurrency ?? "NA"
    }
    
    func returnRate () -> Float {
        return split?.exchangeRate ?? 0
    }
}
