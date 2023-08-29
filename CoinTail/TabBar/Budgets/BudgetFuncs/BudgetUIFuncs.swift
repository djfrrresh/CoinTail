//
//  BudgetsUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 29.06.23.
//

import UIKit
import EasyPeasy


extension BudgetsVC {
    
    func budgetSubviews() {
        self.view.addSubview(budgetCV)
        
        budgetCV.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Bottom()
        ])
    }
    
    func budgetNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (addBudgetAction)
        )
    }
    
}
