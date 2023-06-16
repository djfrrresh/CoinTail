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
    
    let categories = Categories.shared
    
    // Получает операции по типу
    func getRecords(for segment: RecordType) -> [Record] {
        switch segment {
        case .expense:
            return total.filter { $0.type == .expense }
        case .income:
            return total.filter { $0.type == .income }
        case .allOperations:
            return total
        }
    }
        
    // Добавление новой операции и категории в массив
    func addNewOperation(record: Record) {
        total.append(record)
        categoriesUpdate(record: record)
    }
    
    // Получить операцию по ее ID
    func getRecord(for id: Int) -> Record? {
        return total.filter { $0.id == id }.first
    }
        
    func editRecord(for id: Int, replacingRecord: Record, completion: ((Bool) -> Void)? = nil) {
        guard let record = getRecord(for: id) else {
            completion?(false)
            return
        }
        guard let index = total.firstIndex(of: record) else {
            completion?(false)
            return
        }
        total[index] = replacingRecord
        categoriesUpdate()
        completion?(true)
    }
    
    private func categoriesUpdate(record: Record? = nil) {
        if let record = record {
            if !categories.totalCategories.contains(record.category) {
                categories.totalCategories.append(record.category)
            }
        } else {
            var newCategories = [Category]()
            for record in total {
                if !newCategories.contains(record.category) {
                    newCategories.append(record.category)
                }
            }
            categories.totalCategories = newCategories
        }
    }

}
