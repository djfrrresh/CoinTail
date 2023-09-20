//
//  AddBudgetUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit
import EasyPeasy


extension AddBudgetVC {
    
    func setAddBudgetStack() {
        let amountStack = UIStackView()
        setStack(
            stack: amountStack,
            axis: .vertical,
            spacing: 6,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [budgetAmountLabel, budgetAmountTF]
        )
        
        let categoryAmountStack = UIStackView()
        setStack(
            stack: categoryAmountStack,
            axis: .vertical,
            spacing: 16,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [amountStack, categoryButton]
        )
        
        let preFinalStack = UIStackView()
        setStack(
            stack: preFinalStack,
            axis: .vertical,
            spacing: 32,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [periodSwitcher, categoryAmountStack]
        )
        
        let finalStack = UIStackView()
        setStack(
            stack: finalStack,
            axis: .vertical,
            spacing: 70,
            alignment: .fill,
            distribution: .equalCentering,
            viewsArray: [preFinalStack, saveBudgetButton]
        )
        
        self.view.addSubview(finalStack)
        finalStack.easy.layout([
            Left(16),
            Right(16),
            Top(10).to(self.view.safeAreaLayoutGuide, .top),
            Bottom(10).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
        
        self.view.addSubview(currencyButton)
        currencyButton.easy.layout([
            Right(8).to(budgetAmountTF, .right),
            Height(32),
            Width(48),
            CenterY().to(budgetAmountTF)
        ])
    }
    
}
