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

//    var total = [Record]()
    
    // TODO: Сменить на 0, если отсутствует Mock!
    var recordID = 8
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter
    }()
    static let date = "01/02/2019"
    static let date1 = "15/08/2021"
    static let date2 = "27/05/2023"
            
    let categoryColor = Colors.shared
    
    var total = [
        Record(
            amount: 100,
            date: Date(),
            id: 0,
            type: .income,
            categoryID: Categories.shared.categories[.income]![0].id,
            currency: Currency.EUR
        ),
        Record(
            amount: -250,
            date: Date(),
            id: 1,
            type: .expense,
            categoryID: Categories.shared.categories[.expense]![0].id,
            currency: Currency.USD
        ),
        Record(
            amount: 300,
            date: dateFormatter.date(from: date)!,
            id: 2,
            type: .income,
            categoryID: Categories.shared.categories[.income]![3].id,
            currency: Currency.EUR
        ),
        Record(
            amount: 350,
            date: dateFormatter.date(from: date)!,
            id: 3,
            type: .income,
            categoryID: Categories.shared.categories[.income]![3].id,
            currency: Currency.RUB
        ),
        Record(
            amount: -150,
            date: dateFormatter.date(from: date1)!,
            id: 4,
            type: .expense,
            categoryID: Categories.shared.categories[.expense]![2].id,
            currency: Currency.USD
        ),
        Record(
            amount: 400,
            date: dateFormatter.date(from: date1)!,
            id: 5,
            type: .income,
            categoryID: Categories.shared.categories[.income]![1].id,
            currency: Currency.RUB
        ),
        Record(
            amount: -450,
            date: dateFormatter.date(from: date1)!,
            id: 6,
            type: .expense,
            categoryID: Categories.shared.categories[.expense]![4].id,
            currency: Currency.USD
        ),
        Record(
            amount: 500,
            date: dateFormatter.date(from: date2)!,
            id: 7,
            type: .income,
            categoryID: Categories.shared.categories[.income]![0].id,
            currency: Currency.USD
        ),
        Record(
            amount: -550,
            date: dateFormatter.date(from: date2)!,
            id: 8,
            type: .expense,
            categoryID: Categories.shared.categories[.expense]![5].id,
            currency: Currency.EUR
        )
    ]
    
    // Получает сумму из операций за указанный период времени
    func getAmount(for period: DatePeriods, type: RecordType, step: Int = 0, category: Int? = nil) -> Double {
//        let currency = Currencies.shared.selectedCurrency
        let amount: Double = getRecords(for: period, type: type, step: step, categoryID: category).reduce(0.0) { $0 + $1.amount }

        return amount
    }
    
    // Получает операции за указанный период времени
    func getRecords(for period: DatePeriods, type: RecordType, step: Int = 0, categoryID: Int? = nil) -> [Record] {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        
        var array = [Record]()
        // Фильтрация операций по типу
        var records = total.filter { $0.type == type }
        
        if type == .allOperations {
            records = total
        }
        
        // Если выбрана категория, фильтруем по категории
        if let categoryID = categoryID {
            records = records.filter { $0.categoryID == categoryID }
        }
        
        switch period {
        case .allTheTime:
            array = records
        case .year:
            array = records.filter { calendar.component(.year, from: $0.date) == currentYear - step }
        case .quarter:
            let year = Int.norm(hi: currentYear, lo: currentMonth - 1 - step * 3, base: 12).nhi
            let desiredMonth = Int.norm(hi: currentYear, lo: currentMonth - 1 - step * 3, base: 12).nlo + 1
            let desiredQuarter = (desiredMonth - 1) / 3 + 1

            array = records.filter {
                let recordQuarter = (calendar.component(.month, from: $0.date) - 1) / 3 + 1
                let recordYear = calendar.component(.year, from: $0.date)
                
                return recordQuarter == desiredQuarter && recordYear == year
            }
        case .month:
            let year = Int.norm(hi: currentYear, lo: currentMonth - 1 - step, base: 12).nhi
            let desiredMonth = Int.norm(hi: currentYear, lo: currentMonth - 1 - step, base: 12).nlo + 1
            
            array = records.filter { calendar.component(.month, from: $0.date) == desiredMonth && calendar.component(.year, from: $0.date) == year }
        }
        
        return array
    }
        
    // Добавление новой операции
    func addRecord(record: Record) {
        total.append(record)
    }
    
    // Получить операцию по ее ID
    func getRecord(for id: Int) -> Record? {
        return total.filter { $0.id == id }.first
    }
    
    // Удаляет операцию по ее ID
    func deleteRecord(for id: Int, completion: ((Bool) -> Void)? = nil) {
        guard let record = getRecord(for: id),
              let index = total.firstIndex(of: record) else {
            completion?(false)
            return
        }
        
        total.remove(at: index)
        
        completion?(true)
    }
    
    // Отредактировать операцию по ее ID
    func editRecord(for id: Int, replacingRecord: Record, completion: ((Bool) -> Void)? = nil) {
        guard let record = getRecord(for: id),
              let index = total.firstIndex(of: record) else {
            completion?(false)
            return
        }
        
        total[index] = replacingRecord
        
        completion?(true)
    }
    
    // Получает сумму из категории с начальной даты до конечной с указанным периодом (неделя / месяц)
    func getBudgetAmount(date: Date, untilDate: Date, categoryID: Int, currency: Currency) -> Double? {
        let calendar = Calendar.current
        guard let startDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: date)),
              let endDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: untilDate)) else { return nil }
        
        var records = total.filter { $0.type == .expense }
        records = records.filter { $0.categoryID == categoryID && $0.currency == currency }
        
        return records.filter { $0.date >= startDate && $0.date <= endDate }.reduce(0.0) { $0 + $1.amount }
    }
    
    // Посчитать конечный баланс для счёта
    func calculateTotalBalance(for accountID: ObjectId) -> Double {
        let totalAmount = total.reduce(0) { (result, record) -> Double in
            var account = Accounts.shared.getAccount(for: accountID)
            
            // TODO: account, remove return 0
//            if let recordAccountID = record.accountID,
//               recordAccountID == accountID,
//               account?.currency == record.currency {
//                return result + record.amount
//            } else {
//                return result
//            }
            return 0
        }
        
        return totalAmount
    }

}
