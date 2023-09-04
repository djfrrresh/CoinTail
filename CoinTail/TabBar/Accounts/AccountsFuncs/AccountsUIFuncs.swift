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
        self.view.addSubview(accountsCV)
        
        accountsCV.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Bottom()
        ])
    }
    
}
