//
//  BudgetsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 29.06.23.
//

import UIKit


extension BudgetsVC {
    
    func sortBudgets() {
        let budgets = Budgets.shared.budgets
        
        budgetsDaySections = DaySection.groupBudgets(groupBudgets: budgets)
            
        // Отсортировать массив бюджетов по дням (убывание)
        budgetsDaySections.sort { l, r in
            return l.day > r.day
        }
    }
    
    func budgetButtonTargets() {
        addBudgetButton.addTarget(self, action: #selector(goToAddBudgetVC), for: .touchUpInside)
    }
    
}
