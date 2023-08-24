//
//  BudgetsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 29.06.23.
//

import UIKit


extension BudgetsVC {
    
    func filterBudgets() {
        let budgets = Budgets.shared.budgets
        
        daySections = DaySection.groupBudgets(groupBudgets: budgets)
            
        // Отсортировать массив бюджетов по дням (убывание)
        daySections.sort { l, r in
            return l.day > r.day
        }
    }
    
}
