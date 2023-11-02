//
//  AddAccountActions.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AddAccountVC {
    
    @objc func saveAccountAction() {
        guard let amountText = accountAmount,
              let amount = Double(amountText),
              let nameText = accountName else {
            return
        }

        accountValidation(amount: amount, name: nameText) { [weak self] amount, nameText in
            guard let strongSelf = self else { return }

            let currency = strongSelf.selectedCurrency

            let account = AccountClass()
            account.name = nameText
            account.startBalance = amount
            account.currency = "\(currency)"

            if let accountID = strongSelf.accountID {
                account.id = accountID
                Accounts.shared.editAccount(replacingAccount: account)
            } else {
                RealmService.shared.write(account, AccountClass.self)
                Accounts.shared.addNewAccount(account)
            }

            strongSelf.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func doneButtonAction() {
        toolBar.isHidden = true
        currenciesPickerView.isHidden = true
    }
    
    @objc func removeAccount() {
        guard let id = accountID else { return }

        confirmationAlert(
            title: "Delete account".localized(),
            message: "Are you sure?".localized(),
            confirmActionTitle: "Confirm".localized()
        ) { [weak self] in
            Accounts.shared.deleteAccount(for: id)
            
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
