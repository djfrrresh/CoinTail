//
//  AccountsTransferActions.swift
//  CoinTail
//
//  Created by Eugene on 06.09.23.
//

import UIKit
import EasyPeasy


extension AccountsTransferVC: TransferCellDelegate {
    
    func cell(didUpdateTransferAmount amount: String?) {
        transferAmount = amount
    }
    
    @objc func doneButtonAction() {
        toolBar.isHidden = true
        accountsPickerView.isHidden = true
        saveTransferButton.isHidden = false
    }
    
    @objc func saveTransferAction(_ sender: UIButton) {
        let amount = Double(transferAmount ?? "0") ?? 0
        let firstAccount = accountNameFrom ?? ""
        let secondAccount = accountNameTo ?? ""
        
        transferValidation(amount: amount, firstAccount: firstAccount, secondAccount: secondAccount) { [weak self] sourceAccountName, targetAccountName in
            guard let strongSelf = self,
                  let sourceAccount = Accounts.shared.getAccount(for: sourceAccountName),
                  let targetAccount = Accounts.shared.getAccount(for: targetAccountName) else { return }
            
            // Формируем перевод
            Transfers.shared.transferBetweenAccounts(
                from: sourceAccount,
                to: targetAccount,
                amount: amount
            )

            let transferHistory = TransferHistoryClass()
            transferHistory.sourceAccount = sourceAccountName
            transferHistory.targetAccount = targetAccountName
            transferHistory.sourceCurrency = sourceAccount.currency
            transferHistory.targetCurrency = targetAccount.currency
            transferHistory.amount = amount
            transferHistory.date = Date()
            
            // Добавляем в историю перевод между счетами
            Transfers.shared.addNewTransfer(transferHistory)
            
            strongSelf.navigationController?.popViewController(animated: true)
        }
    }
    
}
