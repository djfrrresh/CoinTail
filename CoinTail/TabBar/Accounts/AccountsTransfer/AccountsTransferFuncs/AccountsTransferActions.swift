//
//  AccountsTransferActions.swift
//  CoinTail
//
//  Created by Eugene on 06.09.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import EasyPeasy


extension AccountsTransferVC: TransferCellDelegate {
    
    func cell(didUpdateTransferAmount amount: String?) {
        transferAmount = amount
    }
    
    @objc func saveTransferAction(_ sender: UIButton) {
        let amount = Double(transferAmount ?? "0") ?? 0
        let firstAccount = accountNameFrom ?? ""
        let secondAccount = accountNameTo ?? ""
        
        transferValidation(amount: amount, firstAccount: firstAccount, secondAccount: secondAccount) { [weak self] sourceAccountName, targetAccountName in
            guard let strongSelf = self,
                  let sourceAccount = Accounts.shared.getAccount(for: sourceAccountName),
                  let targetAccount = Accounts.shared.getAccount(for: targetAccountName) else {
                SentryManager.shared.capture(error: "Failed to get source and target accounts", level: .error)
                
                return
            }
            
            // Формируем перевод
            Transfers.shared.transferBetweenAccounts(
                from: sourceAccount,
                to: targetAccount,
                amount: amount
            )
            
            strongSelf.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func transferFromButtonAction() {
        showPickerView()
        
        selectedRowIndex = 0
        accountNameFrom = accountNames[0]
    }
    
    @objc func transferToButtonAction() {
        showPickerView()
        
        selectedRowIndex = 1
        accountNameTo = accountNames[0]
    }
    
}
