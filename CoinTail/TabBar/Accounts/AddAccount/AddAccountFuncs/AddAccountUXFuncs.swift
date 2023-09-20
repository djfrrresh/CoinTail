//
//  AddAccountUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AddAccountVC {
    
    func addAccountTargets() {
        saveAccountButton.addTarget(self, action: #selector(saveAccountAction), for: .touchUpInside)
        currencyButton.addTarget(self, action: #selector(changeCurrency), for: .touchUpInside)
    }
    
    func setCurrency(currencyCode: String) {
        self.currency = Currencies.shared.getCurrency(for: currencyCode)
    }
    
    func accountValidation(amount: Double, name: String, isEditingAccount: Bool, completion: ((Double, String) -> Void)? = nil) {
        let missingName = name == ""
        let accountName = Accounts.shared.getAccount(for: name)?.name

        if missingName {
            errorAlert("No name selected".localized())
        } else if accountName != nil && !isEditingAccount {
            errorAlert("There is already an account with this name".localized())
        } else {
            completion?(amount, name)
        }
    }
    
}
