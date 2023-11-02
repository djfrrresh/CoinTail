//
//  BudgetsUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 29.06.23.
//

import UIKit
import EasyPeasy


extension BudgetsVC {
    
    static func getNoBudgetsLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "You have no budgets set up".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        
        return label
    }
    
    static func getBudgetsDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Here you can set up a budgets for different categories and time periods".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }
    
    func emptyBudgetsSubviews() {
        self.view.addSubview(emptyBudgetsView)
        
        emptyBudgetsView.easy.layout([
            Left(16),
            Right(16),
            Center(),
            Height(BudgetsVC.noDataViewSize(
                noDataLabel: BudgetsVC.getNoBudgetsLabel(),
                descriptionLabel: BudgetsVC.getBudgetsDescriptionLabel()
            ))
        ])

        emptyBudgetsView.addSubview(targetImageView)
        emptyBudgetsView.addSubview(noBudgetsLabel)
        emptyBudgetsView.addSubview(budgetsDescriptionLabel)
        emptyBudgetsView.addSubview(addBudgetButton)
        
        targetImageView.easy.layout([
            Height(100),
            Width(100),
            Top(),
            CenterX()
        ])
        
        noBudgetsLabel.easy.layout([
            Left(),
            Right(),
            Top(32).to(targetImageView, .bottom)
        ])
        
        budgetsDescriptionLabel.easy.layout([
            Left(),
            Right(),
            Top(16).to(noBudgetsLabel, .bottom)
        ])

        addBudgetButton.easy.layout([
            Height(52),
            Left(),
            Right(),
            CenterX(),
            Top(16).to(budgetsDescriptionLabel, .bottom),
            Bottom()
        ])
    }
    
    func budgetSubviews() {
        self.view.addSubview(budgetCV)
        
        budgetCV.easy.layout([
            Top(24).to(self.view.safeAreaLayoutGuide, .top),
            CenterX(),
            Left(16),
            Right(16),
            Bottom()
        ])
    }
    
    func isBudgetEmpty() {
        let isEmpty = budgetsDaySections.isEmpty
        
        targetImageView.isHidden = !isEmpty
        noBudgetsLabel.isHidden = !isEmpty
        budgetsDescriptionLabel.isHidden = !isEmpty
        addBudgetButton.isHidden = !isEmpty
        emptyBudgetsView.isHidden = !isEmpty
        
        budgetCV.isHidden = isEmpty
    }
}
