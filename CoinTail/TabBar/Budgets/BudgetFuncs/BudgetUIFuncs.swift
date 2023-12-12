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
            Top().to(self.view.safeAreaLayoutGuide, .top),
            CenterX(),
            Left(16),
            Right(16),
            Bottom()
        ])
    }
    
    func isBudgetEmpty() {
        let isEmpty = budgets.isEmpty
        
        budgetsImageView.isHidden = !isEmpty
        noBudgetsLabel.isHidden = !isEmpty
        budgetsDescriptionLabel.isHidden = !isEmpty
        addBudgetButton.isHidden = !isEmpty
        emptyDataView.isHidden = !isEmpty
        
        budgetCV.isHidden = isEmpty
        
        if isEmpty {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector (goToAddBudgetVC)
            )
        }
    }
    
}
