//
//  DaySection.swift
//  CoinTail
//
//  Created by Eugene on 11.07.23.
//

import UIKit


struct DaySection {
    var day: Date
    var budgets: [Budget]
    
    static func groupBudgets(groupBudgets: [Budget]) -> [DaySection] {
        let dictionary = Dictionary.init(grouping: groupBudgets) { budget in
            firstDayOfPeriod(date: budget.untilDate)
        }.map { values in
            DaySection(day: values.key, budgets: values.value)
        }
        return dictionary
    }
    
    // TODO: extension for Date
    static func firstDayOfPeriod(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
}
