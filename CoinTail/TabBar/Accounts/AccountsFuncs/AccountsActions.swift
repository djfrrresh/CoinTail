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
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationItem.rightBarButtonItem?.target = nil
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToAccountsTransferVC() {
        let vc = AccountsTransferVC()
        vc.hidesBottomBarWhenPushed = true
                
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToAccountsHistoryVC() {
        let vc = TransfersHistoryVC()
        vc.hidesBottomBarWhenPushed = true
                
        navigationController?.pushViewController(vc, animated: true)
    }
}
