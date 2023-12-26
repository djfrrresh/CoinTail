//
//  AccountsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AccountsVC {
    
    func accountButtonTargets() {
        historyButton.addTarget(self, action: #selector(goToAccountsHistoryVC), for: .touchUpInside)
        transferButton.addTarget(self, action: #selector(goToAccountsTransferVC), for: .touchUpInside)
        addAccountButton.addTarget(self, action: #selector(goToAddAccountVC), for: .touchUpInside)
    }
    
}
