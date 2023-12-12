//
//  TransfersHistoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension TransfersHistoryVC {
    
    func sortTransfers() {
        var transfersArr = Transfers.shared.transfers
        transfersArr.sort { l, r in
            return l.date > r.date
        }

        transfersDaySections = DaySectionTransferHistory.groupTransfers(groupTransfers: transfersArr)
            
        // Отсортировать массив переводов по дням (убывание)
        transfersDaySections.sort { l, r in
            return l.day > r.day
        }
    }
    
    func transferButtonTargets() {
        addTransferButton.addTarget(self, action: #selector(goToAccountsTransferVC), for: .touchUpInside)
    }
    
}
