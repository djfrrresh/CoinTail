//
//  Currencies.swift
//  CoinTail
//
//  Created by Eugene on 13.09.23.
//

import Foundation


class Currencies {
    
    static let shared = Currencies()
    
    let currencyNames = Currency.allCases
    // Перечисление case'ов для получения кода валюты
    let currencyCodes = Currency.allCases.map { "\($0)" }
    
    var selectedCurrency: Currency = Currency.USD
    
    var favouriteCurrencies: [Currency] = [
        Currency.USD,
        Currency.EUR,
        Currency.RUB
    ]
    
    func toggleFavouriteCurrency(_ currency: Currency) {
        if hasCurrency(currency, array: favouriteCurrencies) {
            guard let index = favouriteCurrencies.firstIndex(of: currency) else { return }
            
            favouriteCurrencies.remove(at: index)
        } else {
            favouriteCurrencies.append(currency)
        }
    }
    
    func hasCurrency(_ currency: Currency, array: [Currency]) -> Bool {
        return array.contains(currency)
    }
    
}
