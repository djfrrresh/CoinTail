//
//  AccountsTransferUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 06.09.23.
//

import UIKit


extension AccountsTransferVC {
    
    func accountsTransferTargets() {
        selectFirstAccountButton.addTarget(self, action: #selector(selectFirstAccount), for: .touchUpInside)
        selectSecondAccountButton.addTarget(self, action: #selector(selectSecondAccount), for: .touchUpInside)
        saveTransferButton.addTarget(self, action: #selector(saveTransferAction), for: .touchUpInside)
    }
    
    func transferValidation(amount: Double, completion: ((String, String) -> Void)? = nil) {
        guard let firstAccountButtonText = selectFirstAccountButton.titleLabel?.text,
              let secondAccountButtonText = selectSecondAccountButton.titleLabel?.text else { return }
        
        let missingAmount = abs(amount) == 0
        let missingFirstAccount = firstAccountButtonText == AccountsTransferVC.firstAccountText
        let missingSecondAccount = secondAccountButtonText == AccountsTransferVC.secondAccountText

        if missingAmount {
            errorAlert("Missing value in amount field".localized())
        } else if missingFirstAccount || missingSecondAccount {
            errorAlert("No accounts selected".localized())
        } else if firstAccountButtonText == secondAccountButtonText {
            errorAlert("You cannot select the same account for transfer".localized())
        } else {
            completion?(firstAccountButtonText, secondAccountButtonText)
        }
    }
    
}
