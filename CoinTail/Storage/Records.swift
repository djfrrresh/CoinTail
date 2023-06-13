//
//  Records.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


final class Records {
    
    static let shared = Records()
    
    var records: [RecordType: [Record]] = [.income: [Record](), .expense: [Record](), .allOperations: [Record]()]
    
    var incomes = [Record]()
    var expenses = [Record]()
    var total = [Record]()
        
    func balance(_ type: RecordType?) -> Double {
        guard let type = type, type != .allOperations else {
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
        case .allOperations:
            fatalError("unexpected")
        }
    }
    
}
