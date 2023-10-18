//
//  TransfersHistoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension TransfersHistoryVC {
    
    func sortTransfers() {
        transfers = RealmService.shared.transfersHistoryArr
        
        transfers.sort { l, r in
            return l.date > r.date
        }
    }
    
}
