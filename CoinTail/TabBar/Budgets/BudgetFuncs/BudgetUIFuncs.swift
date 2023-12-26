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
        self.view.addSubview(customNavBar)
        self.view.addSubview(budgetCV)
        
        customNavBar.easy.layout([
            Height(96),
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Left(),
            Right()
        ])
        
        budgetCV.easy.layout([
            Top().to(customNavBar, .bottom),
            CenterX(),
            Left(16),
            Right(16),
            Bottom()
        ])
    }
    
    func areBudgetsEmpty() {
        let isEmpty = budgets.isEmpty
        
        budgetsImageView.isHidden = !isEmpty
        noBudgetsLabel.isHidden = !isEmpty
        budgetsDescriptionLabel.isHidden = !isEmpty
        addBudgetButton.isHidden = !isEmpty
        emptyDataView.isHidden = !isEmpty
        
        budgetCV.isHidden = isEmpty
    }
    
}
