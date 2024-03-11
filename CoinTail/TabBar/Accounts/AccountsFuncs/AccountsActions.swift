//
//  AccountsActions.swift
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


extension AccountsVC {
    
    @objc func goToAddAccountVC() {
        if !AppSettings.shared.premiumStatus.isPremiumActive && accounts.count >= 2 {
            let vc = PremiumAlert(description: "Creating more accounts is only possible with a premium subscription".localized())
            present(vc, animated: true, completion: nil)
        } else {
            let vc = AddAccountVC()
            vc.hidesBottomBarWhenPushed = true
            
            self.navigationItem.rightBarButtonItem?.target = nil
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func goToAccountsTransferVC() {
        if accounts.count >= 2 {
            let vc = AccountsTransferVC()
            vc.hidesBottomBarWhenPushed = true
                    
            navigationController?.pushViewController(vc, animated: true)
        } else {
            infoAlert("Transfers are only available if you have 2 or more accounts".localized())
        }
    }
    
    @objc func goToAccountsHistoryVC() {
        let vc = TransfersHistoryVC()
        vc.hidesBottomBarWhenPushed = true
                
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
