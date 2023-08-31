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
    var budgets: [Budget]
    
    static func groupBudgets(groupBudgets: [Budget]) -> [DaySection] {
        let dictionary = Dictionary.init(grouping: groupBudgets) { budget in
            budget.untilDate.firstDayOfPeriod(components: [.year, .month, .day])
        }.map { values in
            DaySection(day: values.key, budgets: values.value)
        }
        
        return dictionary
    }
}
