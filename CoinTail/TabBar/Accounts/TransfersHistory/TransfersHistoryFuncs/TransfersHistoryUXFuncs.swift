//
//  TransfersHistoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension TransfersHistoryVC {
    
    func sortTransfers() {
        let transfersArr = Transfers.shared.transfers

        transfersDaySections = DaySectionTransferHistory.groupTransfers(groupTransfers: transfersArr)
            
        // Отсортировать массив переводов по дням (убывание)
        transfersDaySections.sort { l, r in
            return l.day > r.day
        }
    }
    
    func transferButtonTargets() {
        addAccountButton.addTarget(self, action: #selector(goToAccountsTransferVC), for: .touchUpInside)
    }
    
}
