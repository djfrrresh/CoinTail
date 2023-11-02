//
//  DaySection.swift
//  CoinTail
//
//  Created by Eugene on 11.07.23.
//

import Foundation


// Секции по дням для бюджетов
struct DaySection {
    var day: Date
    var budgets: [BudgetClass]
    
    static func groupBudgets(groupBudgets: [BudgetClass]) -> [DaySection] {
        let dictionary = Dictionary.init(grouping: groupBudgets) { budget in
            budget.untilDate.firstDayOfPeriod(components: [.year, .month, .day])
        }.map { values in
            DaySection(day: values.key, budgets: values.value)
        }
        
        return dictionary
    }
}

//TODO: сделать 1 структуру для бюджетов и переводов
struct DaySectionTransferHistory {
    var day: Date
    var transfers: [TransferHistoryClass]
    
    static func groupTransfers(groupTransfers: [TransferHistoryClass]) -> [DaySectionTransferHistory] {
        let dictionary = Dictionary.init(grouping: groupTransfers) { transfer in
            transfer.date.firstDayOfPeriod(components: [.year, .month, .day])
        }.map { values in
            DaySectionTransferHistory(day: values.key, transfers: values.value)
        }
        
        return dictionary
    }
}
