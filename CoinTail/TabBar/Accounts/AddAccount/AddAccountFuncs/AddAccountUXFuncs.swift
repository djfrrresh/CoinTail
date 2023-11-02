//
//  AddAccountUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AddAccountVC: AddAccountCellValidate, AddAccountCellDelegate {
    
    func cell(didUpdateAccountName name: String?) {
        accountName = name
    }
    
    func cell(didUpdateAccountAmount amount: String?) {
        accountAmount = amount
    }
    
    func cell(didUpdateOnOffToggle isOn: Bool) {
        isAccountMain = isOn
    }
    
    func textFieldIsEmpty(amountIsEmpty: Bool, nameIsEmpty: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = !(amountIsEmpty && nameIsEmpty)
    }
    
    func addAccountTargets() {
        deleteAccountButton.addTarget(self, action: #selector(removeAccount), for: .touchUpInside)
    }
    
    func accountValidation(amount: Double, name: String, completion: ((Double, String) -> Void)? = nil) {
        let missingName = name == ""
        let missingAmount = "\(amount)" == ""
        let accountName = Accounts.shared.getAccount(for: name)?.name

        if missingName {
            errorAlert("No name selected".localized())
        } else if missingAmount {
            errorAlert("Amount not entered".localized())
        } else if accountName != nil && accountID != nil {
            // TODO: при редактировании жалуется на повтор
            errorAlert("There is already an account with this name".localized())
        } else {
            completion?(amount, name)
        }
    }
    
}
