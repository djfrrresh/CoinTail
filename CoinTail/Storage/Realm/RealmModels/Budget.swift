//
//  Budget.swift
//  CoinTail
//
//  Created by Eugene on 30.06.23.
//

import Foundation
import RealmSwift


class BudgetClass: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var categoryID: ObjectId
    @Persisted var amount: Double = 0
    @Persisted var startDate: Date = Date()
    @Persisted var untilDate: Date = Date()
    @Persisted var currency: String = ""
    var isActive: Bool {
        let calendar = Calendar.current
        
        guard let budgetDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: untilDate)),
              let nowDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date())) else {
            return false
        }
        
        return nowDate < budgetDate
    }
}
