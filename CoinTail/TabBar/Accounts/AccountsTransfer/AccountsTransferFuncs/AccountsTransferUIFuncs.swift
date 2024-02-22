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
        self.view.addSubview(transferFromButton)
        self.view.addSubview(transferToButton)
        
        self.view.addSubview(transferCV)
        self.view.addSubview(saveTransferButton)
        
        transferFromButton.easy.layout([
            Height(64),
            Top(24).to(self.view.safeAreaLayoutGuide, .top),
            Left(16),
            Right(UIScreen.main.bounds.width / 2)
        ])
        transferToButton.easy.layout([
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
            Top(24).to(transferFromButton, .bottom),
            Height(72 * 3),
            Left(),
            Right()
        ])

        transferFromButton.addSubview(transferFromLabel)
        transferToButton.addSubview(transferToLabel)
        
        transferFromButton.addSubview(transferFromAccountNameLabel)
        transferToButton.addSubview(transferToAccountNameLabel)
        
        transferFromButton.addSubview(transferFromAccountBalanceLabel)
        transferToButton.addSubview(transferToAccountBalanceLabel)
        
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
        
        transferFromButton.setImage(UIImage(named: "vectorFromFill"), for: .normal)
        
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
        
        transferToButton.setImage(UIImage(named: "vectorToFill"), for: .normal)

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
