//
//  AddAccountUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AddAccountVC: AddAccountCellDelegate {
    
    func cell(didUpdateAccountName name: String?) {
        accountName = name
    }
    
    func cell(didUpdateAccountAmount amount: String?) {
        accountAmount = amount
    }
    
    func cell(didUpdateOnOffToggle isOn: Bool) {
        isAccountMain = isOn
    }
    
    func addAccountTargets() {
        deleteAccountButton.addTarget(self, action: #selector(removeAccount), for: .touchUpInside)
    }
    
    func accountValidation(amount: Double, name: String, completion: ((Double, String) -> Void)? = nil) {
        let missingName = name == ""
        let missingAmount = "\(amount)" == "" || amount == 0
        let accountName = Accounts.shared.getAccount(for: name)?.name

        if missingName {
            infoAlert("Account name not entered".localized())
        } else if missingAmount {
            infoAlert("Missing value in amount field".localized())
        } else if accountName != nil && accountID == nil {
            infoAlert("There is already an account with this name".localized())
        } else {
            completion?(amount, name)
        }
    }
    
}
