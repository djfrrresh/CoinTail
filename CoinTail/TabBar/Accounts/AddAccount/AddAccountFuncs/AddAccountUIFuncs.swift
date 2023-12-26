//
//  AddAccountUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit
import EasyPeasy


extension AddAccountVC {
    
    func setupUI(with account: AccountClass) {
        let formattedAmount = String(format: "%.2f", account.startBalance)
        accountAmount = "\(formattedAmount)"
        accountName = account.name
        selectedCurrency = account.currency
        
        deleteAccountButton.isHidden = false
    }
    
    func addAccountSubviews() {
        self.view.addSubview(addAccountCV)
        self.view.addSubview(deleteAccountButton)
        
        addAccountCV.easy.layout([
            Left(16),
            Right(16),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            Height(48 * 3)
        ])
        
        deleteAccountButton.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(addAccountCV, .bottom),
            Height(52)
        ])
    }    
    
    func addAccountNavBar() {
        let title = accountID != nil ? "Edit".localized() : "Save".localized()

        let saveButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(saveAccountAction))
            
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func updateCell(at indexPath: IndexPath, text: String) {
        if let cell = addAccountCV.cellForItem(at: indexPath) as? AddAccountCell {
            cell.updateCurrencyLabel(text)
        }
    }
    
}
