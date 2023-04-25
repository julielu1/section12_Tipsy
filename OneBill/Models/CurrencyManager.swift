//
//  CurrencyManager.swift
//  OneBill
//
//  Created by Julie Lu on 25/4/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

protocol CurrencyManagerDelegate {
    func didFetchRate(_ currencyManager: CurrencyManager, currency: CurrencyModel)
    func didFailWithError(error: Error)
}

//Example URL: https://rest.coinapi.io/v1/exchangerate/AUD/USD?apikey=FD525BC6-8A71-4EE2-BB21-A5B50D92E0BE
struct CurrencyManager {
    let currencyURL = "https://rest.coinapi.io/v1/exchangerate"
    let apikey = "FD525BC6-8A71-4EE2-BB21-A5B50D92E0BE"
    
    var delegate: CurrencyManagerDelegate?
    
//    func fetchRate(baseCurrency: String, quotedCurrency: String) {
//        let urlString = "\(currencyURL)/\(baseCurrency)/\(quotedCurrency)?apikey=\(apikey)"
//    }
    
    func fetchRate(baseCurrency: String, quotedCurrency: String, completion: @escaping (Float) -> Void) {
        let urlString = "\(currencyURL)/\(baseCurrency)/\(quotedCurrency)?apikey=\(apikey)"
        performRequest(with: urlString, completion: completion)
    }

    func performRequest(with urlString: String, completion: @escaping (Float) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let currency = self.parseJSON(safeData) {
                        self.delegate?.didFetchRate(self, currency: currency)
                        completion(currency.rate)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ currencyData: Data) -> CurrencyModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            let base = decodedData.asset_id_base
            let quote = decodedData.asset_id_quote
            let rate = decodedData.rate
            
            let currency = CurrencyModel(baseCurrency: base, quotedCurrency: quote, rate: rate)
            return currency
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

