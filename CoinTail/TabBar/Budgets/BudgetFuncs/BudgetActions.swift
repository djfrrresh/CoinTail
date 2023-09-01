//
//  BudgetsActions.swift
//  CoinTail
//
//  Created by Eugene on 29.06.23.
//

import UIKit


extension BudgetsVC {
    
    @objc func goToAddBudgetVC() {
        let vc = AddBudgetVC()
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        
        self.navigationItem.rightBarButtonItem?.target = nil
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
