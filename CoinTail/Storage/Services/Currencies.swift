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
    var selectedCurrency: SelectedCurrencyClass {
        get {
            return realmService.read(SelectedCurrencyClass.self).first ?? createDefaultCurrency()
        }
        set {
            if let currency = realmService.read(SelectedCurrencyClass.self).first {
                realmService.realm?.beginWrite()
                currency.currency = newValue.currency
                
                do {
                    try realmService.realm?.commitWrite()
                } catch {
                    print("Error updating: \(error)")
                }
            } else {
                let defaultCurrency = createDefaultCurrency()
                
                realmService.write(defaultCurrency, SelectedCurrencyClass.self)
            }
            
            // Меняет курсы валют относительно выбранной валюты
            ExchangeRateManager.shared.getExchangeRates {}
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
    func currenciesToChoose() -> [String] {
        var uniqueCurrencies = extractCurrencyStrings(from: favouriteCurrencies)
        
        if !uniqueCurrencies.contains(selectedCurrency.currency) {
            uniqueCurrencies.append(selectedCurrency.currency)
        }

        return uniqueCurrencies
    }
    
    // Получить Realm-объект валюты по ее коду
    func getCurrencyClass(for currencyCode: String) -> FavouriteCurrencyClass {
        let defaultCurrency = FavouriteCurrencyClass()
        defaultCurrency.currency = currencyCode
        
        return favouriteCurrencies.filter { $0.currency == currencyCode }.last ?? defaultCurrency
    }
    
    // Получить имя валюты по ее коду
    func getCurrencyName(for currencyCode: String) -> String {
        return currencyNames.filter { "\($0)" == currencyCode }.last?.rawValue ?? selectedCurrency.currency
    }
    
    func extractCurrencyStrings(from currencies: [FavouriteCurrencyClass]) -> [String] {
        return currencies.map { $0.currency }
    }
    
    func extractCurrencyStrings(from currencies: [Currency]) -> [String] {
        return currencies.map { "\($0)" }
    }
    
    func createDefaultFavouriteCurrenciesIfNeeded() {
        let defaultCurrencies = ["USD", "EUR", "RUB"]

        // Проверяем, есть ли уже избранные валюты в базе данных
        guard realmService.read(FavouriteCurrencyClass.self).isEmpty else {
            return
        }

        // Создаем избранные валюты
        for currencyCode in defaultCurrencies {
            let defaultFavouriteCurrency = FavouriteCurrencyClass()
            defaultFavouriteCurrency.currency = currencyCode

            realmService.write(defaultFavouriteCurrency, FavouriteCurrencyClass.self)
        }
    }
    
    // При первом запуске приложения или очистке данных создать валюту по умолчанию
    private func createDefaultCurrency() -> SelectedCurrencyClass {
        let defaultCurrency = SelectedCurrencyClass()
        defaultCurrency.currency = "USD"
        
        return defaultCurrency
    }
    
}
