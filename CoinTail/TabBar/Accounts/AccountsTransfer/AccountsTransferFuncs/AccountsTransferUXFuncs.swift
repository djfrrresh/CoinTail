//
//  AccountsTransferUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 06.09.23.
//

import UIKit


extension AccountsTransferVC {
    
    func accountsTransferTargets() {
        saveTransferButton.addTarget(self, action: #selector(saveTransferAction), for: .touchUpInside)
    }
    
    func transferValidation(amount: Double, firstAccount: String, secondAccount: String, completion: ((String, String) -> Void)? = nil) {
        let missingAmount = amount == 0
        let missingFirstAccount = firstAccount == ""
        let missingSecondAccount = secondAccount == ""
        var firstAccountCurrency = ""
        var secondAccountCurrency = ""
        
        if let firstAccount = Accounts.shared.getAccount(for: firstAccount) {
            firstAccountCurrency = firstAccount.currency
        }
        if let secondAccount = Accounts.shared.getAccount(for: secondAccount) {
            secondAccountCurrency = secondAccount.currency
        }
        
        if missingAmount {
            errorAlert("Missing value in amount field".localized())
        } else if missingFirstAccount || missingSecondAccount {
            errorAlert("No accounts selected".localized())
        } else if firstAccount == secondAccount {
            errorAlert("You cannot select the same account for transfer".localized())
        } else if firstAccountCurrency != secondAccountCurrency {
            errorAlert("You cannot transfer money to an account with a different currency!".localized())
        } else {
            completion?(firstAccount, secondAccount)
        }
    }
    
}
