//
//  Data.swift
//  CoinTail
//
//  Created by Eugene on 15.12.22.
//

import Foundation

enum RecordType: String {
    case expense = "Expense"
    case income = "Income"
}

class Storage {
    static let shared = Storage()
    var records: [RecordType: [Record]] = [.income: [Record](), .expense: [Record]()]
    
    func balance(_ type: RecordType?) -> Double {
        guard let type = type else {
            return balance(.income) - balance(.expense)
        }
        switch type {
        case .expense:
            return records[type]!.map({ record in
                record.amount
            }).reduce(0, -)
        case .income:
            return records[type]!.map({ record in
                record.amount
            }).reduce(0, +)
        }
    }
}
