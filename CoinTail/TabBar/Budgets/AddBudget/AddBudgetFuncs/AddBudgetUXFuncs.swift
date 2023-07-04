//
//  AddBudgetUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit


extension AddBudgetVC {
    
    func addBudgetActions() {
        saveBudgetButton.addTarget(self, action: #selector(saveBudgetAction), for: .touchUpInside)
    }
    
}
