//
//  AddAccountActions.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
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


extension AddAccountVC {
    
    @objc func saveAccountAction() {
        let amount = Double(accountAmount ?? "0") ?? 0
        let nameText = accountName ?? ""

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
