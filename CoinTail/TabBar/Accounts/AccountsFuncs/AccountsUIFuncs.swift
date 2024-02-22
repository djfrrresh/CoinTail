//
//  AccountsUIFuncs.swift
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


extension AccountsVC: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if !isSelecting {
            if viewController is AccountsVC {
                navigationController.setNavigationBarHidden(true, animated: animated)
            } else {
                navigationController.setNavigationBarHidden(false, animated: animated)
            }
        }
    }

    func accountsSubviews() {
        self.view.addSubview(accountsCV)
        
        var top: PositionAttribute
        var bottom: PositionAttribute
        if !isSelecting {
            self.view.addSubview(customNavBar)
            self.view.addSubview(transferButton)
            self.view.addSubview(historyButton)
            
            customNavBar.easy.layout([
                Height(96),
                Top().to(self.view.safeAreaLayoutGuide, .top),
                Left(),
                Right()
            ])
            
            historyButton.easy.layout([
                Height(52),
                Left(16),
                Right(16),
                CenterX(),
                Bottom(24).to(self.view.safeAreaLayoutGuide, .bottom)
            ])
            
            transferButton.easy.layout([
                Height(52),
                Left(16),
                Right(16),
                CenterX(),
                Bottom(16).to(historyButton, .top)
            ])
            
            top = Top().to(customNavBar, .bottom)
            bottom = Bottom(24).to(transferButton, .top)
        } else {
            self.title = "Accounts".localized()
            
            top = Top().to(self.view.safeAreaLayoutGuide, .top)
            bottom = Bottom()
        }
        
        accountsCV.easy.layout([
            top,
            CenterX(),
            Left(16),
            Right(16),
            bottom
        ])
    }
    
    func isAccountEmpty() {
        let isEmpty = accounts.isEmpty
        
        accountsEmojiLabel.isHidden = !isEmpty
        noAccountsLabel.isHidden = !isEmpty
        accountsDescriptionLabel.isHidden = !isEmpty
        addAccountButton.isHidden = !isEmpty
        emptyDataView.isHidden = !isEmpty
        
        transferButton.isHidden = isEmpty
        historyButton.isHidden = isEmpty
        accountsCV.isHidden = isEmpty
    }
    
}
