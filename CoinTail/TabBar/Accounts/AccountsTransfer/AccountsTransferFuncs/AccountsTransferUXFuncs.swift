//
//  AccountsTransferUXFuncs.swift
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


extension AccountsTransferVC {
    
    func accountsTransferTargets() {
        saveTransferButton.addTarget(self, action: #selector(saveTransferAction), for: .touchUpInside)
        transferFromButton.addTarget(self, action: #selector(transferFromButtonAction), for: .touchUpInside)
        transferToButton.addTarget(self, action: #selector(transferToButtonAction), for: .touchUpInside)
    }
    
    func transferValidation(amount: Double, firstAccount: String, secondAccount: String, completion: ((String, String) -> Void)? = nil) {
        let missingAmount = amount == 0
        let missingFirstAccount = firstAccount == ""
        let missingSecondAccount = secondAccount == ""
//        var firstAccountCurrency = ""
//        var secondAccountCurrency = ""
        
//        if let firstAccount = Accounts.shared.getAccount(for: firstAccount) {
//            firstAccountCurrency = firstAccount.currency
//        }
//        if let secondAccount = Accounts.shared.getAccount(for: secondAccount) {
//            secondAccountCurrency = secondAccount.currency
//        }
        
        if missingAmount {
            infoAlert("Missing value in amount field".localized())
        } else if missingFirstAccount || missingSecondAccount {
            infoAlert("No accounts selected".localized())
        } else if firstAccount == secondAccount {
            infoAlert("You cannot select the same account for transfer".localized())
        }
//        else if firstAccountCurrency != secondAccountCurrency {
            //TODO: premium
//            if AppSettings.shared.premium?.isPremiumActive ?? false {
//                infoAlert("You cannot transfer money to an account with a different currency!".localized())
//            }
//        }
    else {
            completion?(firstAccount, secondAccount)
        }
    }
    
}
