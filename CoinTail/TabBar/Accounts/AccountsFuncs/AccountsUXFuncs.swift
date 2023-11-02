//
//  AccountsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AccountsVC {
    
    func sortAccounts() {
        accounts = RealmService.shared.accountsArr
        
        // Отсортировать массив счетов по деньгам (убывание)
        accounts.sort { l, r in
            return l.amountBalance > r.amountBalance
        }
    }
    
    func accountButtonTargets() {
        historyButton.addTarget(self, action: #selector(goToAccountsHistoryVC), for: .touchUpInside)
        transferButton.addTarget(self, action: #selector(goToAccountsTransferVC), for: .touchUpInside)
        addAccountButton.addTarget(self, action: #selector(goToAddAccountVC), for: .touchUpInside)
    }
    
}
