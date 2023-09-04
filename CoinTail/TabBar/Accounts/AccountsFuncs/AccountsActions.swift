//
//  AccountsActions.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AccountsVC {
    
    @objc func goToAddAccountVC() {
        let vc = AddAccountVC()
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        
        self.navigationItem.rightBarButtonItem?.target = nil
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
