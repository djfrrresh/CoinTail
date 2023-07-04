//
//  BudgetsActions.swift
//  CoinTail
//
//  Created by Eugene on 29.06.23.
//

import UIKit


extension BudgetsVC {
    
    @objc func addBudgetAction() {
        let vc = AddBudgetVC()
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
