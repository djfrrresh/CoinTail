//
//  AccountsUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit
import EasyPeasy


extension AccountsVC {
    
    func accountsNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (goToAddAccountVC)
        )
    }
    
    func accountsSubviews() {
        self.view.addSubview(transferButton)
        self.view.addSubview(historyButton)
        self.view.addSubview(accountsCV)
        
        transferButton.easy.layout([
            Left(40),
            Width(80),
            Height(40),
            Bottom(16).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
        
        historyButton.easy.layout([
            Right(40),
            Width(80),
            Height(40),
            Bottom(16).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
        
        accountsCV.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Bottom(16).to(transferButton, .top)
        ])
    }
    
}
