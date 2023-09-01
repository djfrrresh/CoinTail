//
//  Records.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


final class Records {
    
    static let shared = Records()

    var total = [Record]()
    
    // TODO: Сменить на 0, если отсутствует Mock!
    var recordID = 8
        
    // Получает сумму из операций за указанный период времени
    func getAmount(for period: Periods, type: RecordType, step: Int = 0, category: Category? = nil) -> Double {
        return getRecords(for: period, type: type, step: step, category: category).reduce(0.0) { $0 + $1.amount }
    }
    
    // Получает сумму из категории с начальной даты до конечной с указанным периодом (неделя / месяц)
    func getAmount(date: Date, untilDate: Date, category: Category) -> Double? {
        let calendar = Calendar.current
        guard let startDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: date)),
              let endDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: untilDate)) else { return nil }
        
        var records = total.filter { $0.type == .expense }
        records = records.filter { $0.category == category }
        
        return records.filter { $0.date >= startDate && $0.date <= endDate }.reduce(0.0) { $0 + $1.amount }
    }
    
    //TODO: оптимизировать функцию
    // Получает операции за указанный период времени
    func getRecords(for period: Periods, type: RecordType, step: Int = 0, category: Category? = nil) -> [Record] {
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
        if let category = category {
            records = records.filter { $0.category == category }
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

}
