//
//  AddAccountUXFuncs.swift
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
