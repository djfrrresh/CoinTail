//
//  ExchangeRateManager.swift
//  CoinTail
//
//  Created by Eugene on 28.11.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
