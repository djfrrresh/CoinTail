//
//  BudgetPeriodUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit
import EasyPeasy


extension BudgetPeriodVC {
    
    func periodsSubviews() {
        self.view.addSubview(periodsCV)
        
        periodsCV.easy.layout([
            Left(16),
            Right(16),
            CenterY(),
            Top(24).to(self.view.safeAreaLayoutGuide, .top),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom)
        ])
    }
    
}
