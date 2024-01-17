//
//  AccountsTransferUIFuncs.swift
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


extension AccountsTransferVC {
    
    func transferSubviews() {
        self.view.addSubview(transferFromBackView)
        self.view.addSubview(transferToBackView)
        
        self.view.addSubview(transferCV)
        self.view.addSubview(saveTransferButton)
        
        transferFromBackView.easy.layout([
            Height(64),
            Top(24).to(self.view.safeAreaLayoutGuide, .top),
            Left(16),
            Right(UIScreen.main.bounds.width / 2)
        ])
        transferToBackView.easy.layout([
            Height(64),
            Top(24).to(self.view.safeAreaLayoutGuide, .top),
            Right(16),
            Left(UIScreen.main.bounds.width / 2)
        ])
        
        saveTransferButton.easy.layout([
            Left(16),
            Right(16),
            Bottom(24).to(self.view.safeAreaLayoutGuide, .bottom),
            Height(52)
        ])
        
        transferCV.easy.layout([
            Top(24).to(transferFromBackView, .bottom),
            Height(72 * 3),
            Left(),
            Right()
        ])
        
        transferFromBackView.addSubview(transferFromBackViewFill)
        transferToBackView.addSubview(transferToBackViewFill)
        
        transferFromBackViewFill.easy.layout([
            Edges()
        ])
        transferToBackViewFill.easy.layout([
            Edges()
        ])
        
        transferFromBackViewFill.addSubview(transferFromLabel)
        transferToBackViewFill.addSubview(transferToLabel)
        
        transferFromBackViewFill.addSubview(transferFromAccountNameLabel)
        transferToBackViewFill.addSubview(transferToAccountNameLabel)
        
        transferFromBackViewFill.addSubview(transferFromAccountBalanceLabel)
        transferToBackViewFill.addSubview(transferToAccountBalanceLabel)
        
        transferFromLabel.easy.layout([
            Left(16),
            CenterY()
        ])
        transferToLabel.easy.layout([
            Left(24),
            CenterY()
        ])
        
        transferFromAccountNameLabel.easy.layout([
            Top(8),
            Left(16),
            Right(24)
        ])
        transferToAccountNameLabel.easy.layout([
            Top(8),
            Left(24),
            Right(16)
        ])
        
        transferFromAccountBalanceLabel.easy.layout([
            Bottom(8),
            Left(16),
            Right(24)
        ])
        transferToAccountBalanceLabel.easy.layout([
            Bottom(8),
            Left(24),
            Right(16)
        ])
    }
    
    func showTransferFrom() {
        guard let accountNameFrom = accountNameFrom,
              let account = Accounts.shared.getAccount(for: accountNameFrom) else { return }

        transferFromBackView.image = transferFromBackView.image?.withRenderingMode(.alwaysTemplate)
        transferFromBackView.tintColor = .white
        transferFromBackViewFill.tintColor = UIColor.white
        
        transferFromLabel.isHidden = true
        transferFromAccountNameLabel.isHidden = false
        transferFromAccountBalanceLabel.isHidden = false
                
        transferFromAccountNameLabel.text = accountNameFrom
        let formattedAmount = String(format: "%.2f", account.amountBalance)
        transferFromAccountBalanceLabel.text = "\(formattedAmount) \(account.currency)"
    }
    
    func showTransferTo() {
        guard let accountNameTo = accountNameTo,
              let account = Accounts.shared.getAccount(for: accountNameTo) else { return }

        transferToBackView.image = transferToBackView.image?.withRenderingMode(.alwaysTemplate)
        transferToBackView.tintColor = UIColor.white
        transferToBackViewFill.tintColor = UIColor.white

        transferToLabel.isHidden = true
        transferToAccountNameLabel.isHidden = false
        transferToAccountBalanceLabel.isHidden = false
                
        transferToAccountNameLabel.text = accountNameTo
        let formattedAmount = String(format: "%.2f", account.amountBalance)
        transferToAccountBalanceLabel.text = "\(formattedAmount) \(account.currency)"
    }

    func updateCell(at indexPath: IndexPath, text: String) {
        if let cell = transferCV.cellForItem(at: indexPath) as? TransferCell {
            cell.updateAccountNameLabel(text)
        }
    }
    
}
