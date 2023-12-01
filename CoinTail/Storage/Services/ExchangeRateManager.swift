//
//  ExchangeRateManager.swift
//  CoinTail
//
//  Created by Eugene on 28.11.23.
//

import Foundation


final class ExchangeRateManager {
    
    static let shared = ExchangeRateManager()
    
    private let exchangeAPIEndpoint = "https://v6.exchangerate-api.com/v6/"

    func getExchangeRates(forCurrencyCode currencyCode: String, completion: @escaping ([String: Double]?) -> Void) {
        guard let apiKey = KeychainManager.shared.getAPIKeyFromKeychain() else {
            completion(nil)
            return
        }
        
        let urlString = "\(exchangeAPIEndpoint)\(apiKey)/latest/\(currencyCode)"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = jsonResponse as? [String: Any],
                       let conversionRates = jsonDict["conversion_rates"] as? [String: Double] {
                        completion(conversionRates)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                    completion(nil)
                }
            }.resume()
        } else {
            print("Error: Invalid URL")
            completion(nil)
        }
    }
    
}
