//
//  BudgetsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 29.06.23.
//

import UIKit


extension BudgetsVC {
    
    func budgetButtonTargets() {
        addBudgetButton.addTarget(self, action: #selector(goToAddBudgetVC), for: .touchUpInside)
        customNavBar.customButton.addTarget(self, action: #selector(goToAddBudgetVC), for: .touchUpInside)
    }
    
}
