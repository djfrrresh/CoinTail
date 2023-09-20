//
//  Currencies.swift
//  CoinTail
//
//  Created by Eugene on 13.09.23.
//

import Foundation


class Currencies {
    
    static let shared = Currencies()
    
    let currencyNames: [Currency] = Currency.allCases
    // Перечисление case'ов для получения кода валюты
    let currencyCodes: [String] = Currency.allCases.map { "\($0)" }
    
    var selectedCurrency: Currency = Currency.USD
    var favouriteCurrencies: [Currency] = [
        Currency.USD,
        Currency.EUR,
        Currency.RUB
    ]
    
    // Добавить / удалить валюту из избранных
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
    
    // Возвращаем массив с уникальными валютами из избранных + выбранной валюты
    func currenciesToChoose() -> [Currency] {
        var combinedCurrencies: [Currency] = [selectedCurrency] + favouriteCurrencies
        
        if let index = combinedCurrencies.firstIndex(of: selectedCurrency) {
            combinedCurrencies.remove(at: index)
        }
                
        return combinedCurrencies
    }
    
    func getNextIndex(currentIndex: Int) -> Int {
        let currencies: [Currency] = Currencies.shared.currenciesToChoose()
        let nextIndex = currentIndex + 1
                                
        return nextIndex < currencies.count ? nextIndex : 0
    }
    
    func getCurrency(for currencyCode: String) -> Currency {
        return currenciesToChoose().filter { "\($0)" == currencyCode }.last ?? selectedCurrency
    }
    
}
