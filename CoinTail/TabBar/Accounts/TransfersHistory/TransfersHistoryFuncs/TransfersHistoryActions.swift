//
//  TransfersHistoryActions.swift
//  CoinTail
//
//  Created by Eugene on 26.10.23.
//

import UIKit


extension TransfersHistoryVC {
    
    @objc func goToAccountsTransferVC() {
        let vc = AccountsTransferVC()
        vc.hidesBottomBarWhenPushed = true
                
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
