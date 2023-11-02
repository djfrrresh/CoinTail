//
//  Currencies.swift
//  CoinTail
//
//  Created by Eugene on 13.09.23.
//

import Foundation


class Currencies {
    
    static let shared = Currencies()
    
    private let realmService = RealmService.shared
    
    let currencyNames: [Currency] = Currency.allCases
    // Перечисление case'ов для получения кода валюты
    let currencyCodes: [String] = Currency.allCases.map { "\($0)" }
    
    // Избранные валюты
    var favouriteCurrencies: [FavouriteCurrencyClass] {
        get {
            return RealmService.shared.favouriteCurrenciesArr
        }
    }
    // Выбранная валюта
    var selectedCurrency: FavouriteCurrencyClass {
        get {
            return realmService.read(FavouriteCurrencyClass.self).first ?? createDefaultCurrency()
        }
        set {
            if let currency = realmService.read(FavouriteCurrencyClass.self).first {
                realmService.realm?.beginWrite()
                currency.currency = newValue.currency
                
                do {
                    try realmService.realm?.commitWrite()
                } catch {
                    print("Error updating: \(error)")
                }
            } else {
                let defaultCurrency = createDefaultCurrency()
                
                realmService.write(defaultCurrency, FavouriteCurrencyClass.self)
            }
        }
    }
    
    // Добавить / удалить валюту из избранных
    func toggleFavouriteCurrency(_ currency: FavouriteCurrencyClass) {
        if hasCurrency(currency.currency, array: extractCurrencyStrings(from: favouriteCurrencies)) {
            RealmService.shared.delete(currency, FavouriteCurrencyClass.self)
        } else {
            RealmService.shared.write(currency, FavouriteCurrencyClass.self)
        }
    }
    
    // Проверить наличие валюты в избранных
    func hasCurrency(_ currency: String, array: [String]) -> Bool {
        return array.contains(currency)
    }
    
    // Возвращаем массив с валютами из избранных + выбранную валюту
    func currenciesToChoose() -> [FavouriteCurrencyClass] {
        var combinedCurrencies = [selectedCurrency] + favouriteCurrencies
        
        if let index = combinedCurrencies.firstIndex(of: selectedCurrency) {
            combinedCurrencies.remove(at: index)
        }
                
        return combinedCurrencies
    }
    
    // Получить Realm-объект валюты по ее коду
    func getCurrencyClass(for currencyCode: String) -> FavouriteCurrencyClass {
        return currenciesToChoose().filter { "\($0)" == currencyCode }.last ?? selectedCurrency
    }
    // Получить имя валюты по ее коду
    func getCurrencyName(for currencyCode: String) -> String {
        return currencyNames.filter { "\($0)" == currencyCode }.last?.name ?? selectedCurrency.currency
    }
    
    // Конвертировать строковый код валюты в Realm объект
    func createFavouriteCurrencyFromCurrency(_ currency: String) -> FavouriteCurrencyClass {
        let favouriteCurrency = FavouriteCurrencyClass()
        favouriteCurrency.currency = currency
        
        RealmService.shared.write(favouriteCurrency, FavouriteCurrencyClass.self)
        
        return favouriteCurrency
    }
    
    func extractCurrencyStrings(from currencies: [FavouriteCurrencyClass]) -> [String] {
        return currencies.map { $0.currency }
    }
    
    // При первом запуске приложения создать валюту по умолчанию
    private func createDefaultCurrency() -> FavouriteCurrencyClass {
        let defaultCurrency = FavouriteCurrencyClass()
        defaultCurrency.currency = "USD"
        
        return defaultCurrency
    }
    
}
