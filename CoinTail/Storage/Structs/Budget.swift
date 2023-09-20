//
//  Budget.swift
//  CoinTail
//
//  Created by Eugene on 30.06.23.
//

import Foundation


struct Budget: Equatable {
    var category: Category
    var amount: Double
    var startDate: Date
    var untilDate: Date
    var id: Int
    var currency: Currency
    var isActive: Bool? { // Проверка бюджета на активность по дате
        let calendar = Calendar.current
        
        // Сверяется текущая дата с датой начала бюджета
        guard let budgetDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: untilDate)),
              let nowDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date())) else { return nil }

        return nowDate < budgetDate
    }
}
