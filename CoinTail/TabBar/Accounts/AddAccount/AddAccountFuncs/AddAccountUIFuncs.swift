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
        accountAmount = "\(account.startBalance)"
        accountName = account.name
        selectedCurrency = account.currency
        
        deleteAccountButton.isHidden = false
    }
    
    func addAccountSubviews() {
        self.view.addSubview(addAccountCV)
        self.view.addSubview(deleteAccountButton)
        self.view.addSubview(currenciesPickerView)
        self.view.addSubview(toolBar)
        
        addAccountCV.easy.layout([
            Left(16),
            Right(16),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            Height(48 * 4)
        ])
        
        deleteAccountButton.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(addAccountCV, .bottom),
            Height(52)
        ])
        
        currenciesPickerView.easy.layout([
            Left(),
            Right(),
            Height(200),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom)
        ])
        
        toolBar.easy.layout([
            Left(),
            Right(),
            Height(44),
            Bottom().to(currenciesPickerView, .top)
        ])
    }    
    
    func addAccountNavBar() {
        let title = accountID != nil ? "Edit".localized() : "Save".localized()

        let saveButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(saveAccountAction))
            
        self.navigationItem.rightBarButtonItem = saveButton
//        self.navigationItem.rightBarButtonItem?.isEnabled = accountID != nil ? true : false
    }
    
    //TODO: вынести эту функцию в basicVC
    func setupToolBar() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonAction)
        )

        toolBar.setItems([doneButton], animated: true)
    }
    
    func updateCell(at indexPath: IndexPath) {
        if let cell = addAccountCV.cellForItem(at: indexPath) as? AddAccountCell {
            cell.updateCurrencyLabel(selectedCurrency)
        }
    }
    
}
