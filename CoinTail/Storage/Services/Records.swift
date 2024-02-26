//
//  Records.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
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

import UIKit
import RealmSwift


final class Records {
    
    static let shared = Records()
    
    var records: [RecordClass] {
        get {
            return RealmService.shared.recordsArr
        }
    }
        
    // Получает операции за указанный период времени
    func getRecords(for period: DatePeriods, type: RecordType, step: Int = 0, categoryID: ObjectId? = nil) -> [RecordClass] {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        
        var filteredRecords = [RecordClass]()
        // Фильтрация операций по типу
        var totalRecords = records.filter { $0.type == type.rawValue }
        
        if type == .allOperations {
            totalRecords = records
        }
        
        // Если выбрана категория, фильтруем по ней и подкатегориям выбранной категории
        if let categoryID = categoryID {
            let filteredRecords = totalRecords.filter { record in
                if record.categoryID == categoryID {
                    return true
                } else if let subcategory = Categories.shared.getSubcategory(for: record.categoryID), subcategory.parentCategory == categoryID {
                    return true
                }
                return false
            }
            
            totalRecords = filteredRecords
        }
        
        switch period {
        case .allTheTime:
            filteredRecords = totalRecords
        case .year:
            filteredRecords = totalRecords.filter { calendar.component(.year, from: $0.date) == currentYear - step }
        case .quarter:
            let year = Int.norm(hi: currentYear, lo: currentMonth - 1 - step * 3, base: 12).nhi
            let desiredMonth = Int.norm(hi: currentYear, lo: currentMonth - 1 - step * 3, base: 12).nlo + 1
            let desiredQuarter = (desiredMonth - 1) / 3 + 1
            
            filteredRecords = totalRecords.filter {
                let recordQuarter = (calendar.component(.month, from: $0.date) - 1) / 3 + 1
                let recordYear = calendar.component(.year, from: $0.date)
                                
                return recordQuarter == desiredQuarter && recordYear == year
            }
        case .month:
            let year = Int.norm(hi: currentYear, lo: currentMonth - 1 - step, base: 12).nhi
            let desiredMonth = Int.norm(hi: currentYear, lo: currentMonth - 1 - step, base: 12).nlo + 1
            
            filteredRecords = totalRecords.filter {
                calendar.component(.month, from: $0.date) == desiredMonth && calendar.component(.year, from: $0.date) == year
            }
        }
        
        return filteredRecords
    }
        
    // Добавление новой операции
    func addRecord(record: RecordClass) {
        RealmService.shared.write(record, RecordClass.self)
    }
    
    // Получить операцию по ее ID
    func getRecord(for id: ObjectId) -> RecordClass? {
        return records.filter { $0.id == id }.first
    }
    
    // Отредактировать операцию по ее ID
    func editRecord(replacingRecord: RecordClass, completion: ((Bool) -> Void)? = nil) {
        RealmService.shared.update(replacingRecord, RecordClass.self)
        
        completion?(true)
    }
    
    // Удаляет операцию по ее ID
    func deleteRecord(for id: ObjectId, completion: ((Bool) -> Void)? = nil) {
        guard let record = getRecord(for: id) else {
            SentryManager.shared.capture(error: "No record to delete", level: .error)
            completion?(false)
            
            return
        }
        
        RealmService.shared.delete(record, RecordClass.self)
        
        completion?(true)
    }
    
    // Получает сумму из операций за указанный период времени
    func getAmount(for period: DatePeriods, type: RecordType, step: Int = 0, categoryID: ObjectId? = nil, completion: (Double?) -> Void) {
        let selectedCurrency = Currencies.shared.selectedCurrency.currency
        let records = getRecords(for: period, type: type, step: step, categoryID: categoryID)

        // Проверка премиум-статуса
        //TODO: premium
//        if AppSettings.shared.premium?.isPremiumActive ?? false {
            // Получить уникальные валюты
            let uniqueCurrencies = Set(records.map { $0.currency })
            // Получить курсы обмена для каждой валюты
            let exchangeRates = ExchangeRateManager.shared.exchangeRates[selectedCurrency]

            guard let exchangeRates = exchangeRates else {
                SentryManager.shared.capture(error: "Failed to get exchange rates for period", level: .error)
                completion(nil)
                
                return
            }

            var totalAmountInSelectedCurrency: Double = 0.0

            for currency in uniqueCurrencies {
                var filteredRecords: [RecordClass] {
                    get {
                        records.filter { $0.currency == currency }
                    }
                }

                let totalAmountInCurrency = filteredRecords.reduce(0.0) { total, record in
                    if let exchangeRate = exchangeRates[currency] {
                        return total + (record.amount / exchangeRate)
                    }
                    
                    return total
                }

                totalAmountInSelectedCurrency += totalAmountInCurrency
            }

            completion(totalAmountInSelectedCurrency)
//        } else {
//            records = records.filter { $0.currency == selectedCurrency }
//
//            let totalAmount = records.reduce(0.0) { $0 + $1.amount }
//
//            completion(totalAmount)
//        }
    }
    
    // Получает сумму из категории с начальной даты до конечной с указанным периодом (неделя / месяц)
    func getBudgetAmount(budgetID: ObjectId, completion: (Double?) -> Void) {
        guard let budget = Budgets.shared.getBudget(for: budgetID),
              let category = Categories.shared.getCategory(for: budget.categoryID) else {
            SentryManager.shared.capture(error: "Failed to get budget or category", level: .error)
            
            return
        }

        let allSubcategoryIDs: [ObjectId] = [category.id] + category.subcategories
        let startDate = budget.startDate
        let untilDate = budget.untilDate

        var totalAmount: Double = 0

        // Получаем все записи для всех категорий и подкатегорий
        // Фильтруем записи по датам
        let records = self.records.filter {
            $0.type == RecordType.expense.rawValue
            && allSubcategoryIDs.contains($0.categoryID)
            && $0.date >= startDate && $0.date <= untilDate
        }
                
        //TODO: premium
//        if AppSettings.shared.premium?.isPremiumActive ?? false {
        for record in records {
            if budget.currency == record.currency {
                totalAmount += record.amount
            } else {
                let baseCurrency = Currencies.shared.selectedCurrency.currency

                guard let exchangeRatesToBase = ExchangeRateManager.shared.exchangeRates[baseCurrency],
                    let exchangeRateFromBase = exchangeRatesToBase[budget.currency],
                    let exchangeRateToBase = exchangeRatesToBase[record.currency] else {
                    SentryManager.shared.capture(error: "Failed to get exchange rates for records", level: .error)
                    completion(nil)
                    
                    return
                }

                let convertedToBase = record.amount / exchangeRateToBase
                let convertedToAccountCurrency = convertedToBase * exchangeRateFromBase
                                
                totalAmount += convertedToAccountCurrency                
            }
        }
//        } else {
//            records = records.filter { $0.currency == budget.currency }
//            totalAmount = records.reduce(0.0) { $0 + $1.amount }
//        }

        completion(totalAmount)
    }
        
    // Считает конечный баланс для счёта
    func calculateTotalBalance(for accountID: ObjectId, completion: (Double?) -> Void) {
        guard let account = Accounts.shared.getAccount(for: accountID) else {
            SentryManager.shared.capture(error: "No account to calculate balance", level: .error)
            completion(nil)
            
            return
        }

        var totalAmount: Double = 0

        //TODO: premium
//        if AppSettings.shared.premium?.isPremiumActive ?? false {
        for record in records {
            guard let recordAccountID = record.accountID, recordAccountID == accountID else {
                continue
            }
            
            if account.currency == record.currency {
                totalAmount += record.amount
            } else {
                let baseCurrency = Currencies.shared.selectedCurrency.currency

                guard let exchangeRatesToBase = ExchangeRateManager.shared.exchangeRates[baseCurrency],
                    let exchangeRateFromBase = exchangeRatesToBase[account.currency],
                    let exchangeRateToBase = exchangeRatesToBase[record.currency] else {
                    SentryManager.shared.capture(error: "No exchange rates to calculate account balance", level: .error)
                    completion(nil)
                    
                    return
                }
                
                let convertedToBase = record.amount / exchangeRateToBase
                let convertedToAccountCurrency = convertedToBase * exchangeRateFromBase
                                
                totalAmount += convertedToAccountCurrency
            }
        }
//        } else {
//            let records = records.filter { $0.currency == account.currency }
//
//            totalAmount = records.reduce(0.0) { $0 + $1.amount }
//        }

        completion(totalAmount)
    }

}
