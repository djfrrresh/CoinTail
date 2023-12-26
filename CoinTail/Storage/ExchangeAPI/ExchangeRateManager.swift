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
    
    var exchangeRates: [String: [String: Double]] = [:] {
        didSet {
            // Ставим уведомление на обновление курсов валют
            NotificationCenter.default.post(name: Notification.Name("ExchangeRatesUpdated"), object: nil)
        }
    }

    func getExchangeRates(completion: @escaping () -> Void) {
        let currencyCode = Currencies.shared.selectedCurrency.currency

        if exchangeRates[currencyCode] != nil {
            // Если курсы валют для указанной валюты уже кешированы, возвращаем их
            completion()
        } else {
            // В противном случае делаем запрос к API
            guard let apiKey = KeychainManager.shared.getAPIKeyFromKeychain() else {
                completion()
                return
            }
            
            let urlString = "\(exchangeAPIEndpoint)\(apiKey)/latest/\(currencyCode)"
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data, error == nil else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error")")
                        completion()
                        return
                    }
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonDict = jsonResponse as? [String: Any],
                           let conversionRates = jsonDict["conversion_rates"] as? [String: Double] {
                            // Кэшируем полученные курсы валют
                            self.exchangeRates[currencyCode] = conversionRates
                        } else {
                            completion()
                            return
                        }
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                        completion()
                        return
                    }

                    // Завершаем выполнение запроса и вызываем замыкание
                    completion()
                }.resume()
            } else {
                print("Error: Invalid URL")
                completion()
            }
        }
    }
    
}
