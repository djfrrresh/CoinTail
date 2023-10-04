//
//  TransfersHistoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension TransfersHistoryVC {
    
    func sortTransfers() {
        transfers = Transfers.shared.transfersHistory
        
        transfers.sort { l, r in
            return l.date > r.date
        }
    }
    
}
