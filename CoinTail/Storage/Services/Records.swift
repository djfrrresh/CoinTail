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
    func getAmount(for period: DatePeriods, type: RecordType, step: Int = 0, category: ObjectId? = nil) -> Double {
        let amount: Double = getRecords(for: period, type: type, step: step, categoryID: category).reduce(0.0) { $0 + $1.amount }

        return amount
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
        
        // Если выбрана категория, фильтруем по категории
        if let categoryID = categoryID {
            totalRecords = totalRecords.filter { $0.categoryID == categoryID }
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
    func getBudgetAmount(date: Date, untilDate: Date, categoryID: ObjectId, currency: Currency) -> Double? {
        let calendar = Calendar.current
        guard let startDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: date)),
              let endDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: untilDate)) else { return nil }
        
        var records = records.filter { $0.type == "Expense" }
        records = records.filter { $0.categoryID == categoryID && $0.currency == "\(currency)" }
        
        return records.filter { $0.date >= startDate && $0.date <= endDate }.reduce(0.0) { $0 + $1.amount }
    }
    
    // Посчитать конечный баланс для счёта
    func calculateTotalBalance(for accountID: ObjectId) -> Double {
        let totalAmount = records.reduce(0) { (result, record) -> Double in
            let account = Accounts.shared.getAccount(for: accountID)
            
            if let recordAccountID = record.accountID,
               recordAccountID == accountID,
               account?.currency == record.currency {
                return result + record.amount
            } else {
                return result
            }
        }
        
        return totalAmount
    }

}
