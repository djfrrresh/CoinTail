//
//  Records.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit
import RealmSwift


final class Records {
    
    static let shared = Records()
    
    var records: [RecordClass] {
        get {
            return RealmService.shared.recordsArr
        }
    }
    
    // Получает сумму из операций за указанный период времени
    func getAmount(for period: DatePeriods, type: RecordType, step: Int = 0, categoryID: ObjectId? = nil, completion: @escaping (Double?) -> Void) {
        // Получить уникальные валюты
        let uniqueCurrencies = Set(records.map { $0.currency })
        let selectedCurrency = Currencies.shared.selectedCurrency.currency

        // Получить курсы обмена для каждой валюты
        let exchangeRates = ExchangeRateManager.shared.exchangeRates[selectedCurrency]

        guard let exchangeRates = exchangeRates else {
            print("Failed to get exchangeRates")
            completion(nil)
            return
        }

        var totalAmountInSelectedCurrency: Double = 0.0

        for currency in uniqueCurrencies {
            let currencyRecords = getRecords(for: period, type: type, step: step, categoryID: categoryID).filter { $0.currency == currency }

            let totalAmountInCurrency = currencyRecords.reduce(0.0) { total, record in
                if let exchangeRate = exchangeRates[currency] {
                    return total + (record.amount / exchangeRate)
                }
                return total
            }
            
            totalAmountInSelectedCurrency += totalAmountInCurrency
        }

        completion(totalAmountInSelectedCurrency)
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
            // TODO: есть баг с прокруткой влево 4 раза когда там нет операций
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
            
            filteredRecords = totalRecords.filter { calendar.component(.month, from: $0.date) == desiredMonth && calendar.component(.year, from: $0.date) == year }
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
            completion?(false)
            return
        }
        
        RealmService.shared.delete(record, RecordClass.self)
        
        completion?(true)
    }
    
    // Получает сумму из категории с начальной даты до конечной с указанным периодом (неделя / месяц)
    func getBudgetAmount(budgetID: ObjectId, completion: @escaping (Double?) -> Void) {
        guard let budget = Budgets.shared.getBudget(for: budgetID),
              let category = Categories.shared.getCategory(for: budget.categoryID) else { return }
        
        let allSubcategoryIDs: [ObjectId] = [category.id] + category.subcategories
        let currency = budget.currency
        let date = budget.startDate
        let untilDate = budget.untilDate
        
        var totalAmount: Double = 0
        
        // Получаем все записи для всех категорий и подкатегорий
        // Фильтруем записи по датам
        let records = self.records.filter {
            $0.type == RecordType.expense.rawValue
            && allSubcategoryIDs.contains($0.categoryID)
            && $0.date >= date && $0.date <= untilDate
        }
        
        // Считаем сумму
        for record in records {
            if record.currency == currency {
                totalAmount += record.amount
            } else {
                let exchangeRates = ExchangeRateManager.shared.exchangeRates[currency]

                guard let exchangeRates = exchangeRates,
                      let exchangeRate = exchangeRates[record.currency] else {
                    print("Failed to get exchangeRates")
                    completion(nil)
                    return
                }

                let convertedAmount = record.amount / exchangeRate
                totalAmount += convertedAmount
            }
        }
        
        completion(totalAmount)
    }
    
    // Считает конечный баланс для счёта
    func calculateTotalBalance(for accountID: ObjectId, completion: @escaping (Double?) -> Void) {
        var totalAmount: Double = 0

        for record in records {
            if let recordAccountID = record.accountID,
               recordAccountID == accountID,
               let account = Accounts.shared.getAccount(for: accountID) {
                
                if account.currency == record.currency {
                    totalAmount += record.amount
                } else {
                    let exchangeRates = ExchangeRateManager.shared.exchangeRates[account.currency]

                    guard let exchangeRates = exchangeRates,
                          let exchangeRate = exchangeRates[record.currency] else {
                        print("Failed to get exchangeRates")
                        completion(nil)
                        return
                    }

                    let convertedAmount = record.amount / exchangeRate
                    totalAmount += convertedAmount
                }
            }
        }
        
        completion(totalAmount)
    }

}
