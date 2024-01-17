//
//  AddAccountUIFuncs.swift
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
import EasyPeasy


extension AddAccountVC {
    
    func setupUI(with account: AccountClass) {
        let formattedAmount = String(format: "%.2f", account.startBalance)
        accountAmount = "\(formattedAmount)"
        accountName = account.name
        selectedCurrency = account.currency
        
        deleteAccountButton.isHidden = false
    }
    
    func addAccountSubviews() {
        self.view.addSubview(addAccountCV)
        self.view.addSubview(deleteAccountButton)
        
        addAccountCV.easy.layout([
            Left(16),
            Right(16),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            Height(48 * 3)
        ])
        
        deleteAccountButton.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(addAccountCV, .bottom),
            Height(52)
        ])
    }    
    
    func addAccountNavBar() {
        let saveButton = UIBarButtonItem(title: "Save".localized(), style: .plain, target: self, action: #selector(saveAccountAction))
            
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func updateCell(at indexPath: IndexPath, text: String) {
        if let cell = addAccountCV.cellForItem(at: indexPath) as? AddAccountCell {
            cell.updateCurrencyLabel(text)
        }
    }
    
}
