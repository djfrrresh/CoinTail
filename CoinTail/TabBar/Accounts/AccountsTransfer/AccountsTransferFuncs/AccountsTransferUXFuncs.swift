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
    
    func transferValidation(amount: Double, completion: ((String, String) -> Void)? = nil) {
        guard let firstAccountCurrency = Accounts.shared.getAccount(for: accountNameFrom)?.currency,
              let secondAccountCurrency = Accounts.shared.getAccount(for: accountNameTo)?.currency else { return }

        let missingAmount = amount == 0
        let missingFirstAccount = accountNameFrom == ""
        let missingSecondAccount = accountNameTo == ""
        
        if missingAmount {
            errorAlert("Missing value in amount field".localized())
        } else if missingFirstAccount || missingSecondAccount {
            errorAlert("No accounts selected".localized())
        } else if accountNameFrom == accountNameTo {
            errorAlert("You cannot select the same account for transfer".localized())
        } else if firstAccountCurrency != secondAccountCurrency {
            errorAlert("You cannot transfer money to an account with a different currency!".localized())
        } else {
            completion?(accountNameFrom, accountNameTo)
        }
    }
    
}
