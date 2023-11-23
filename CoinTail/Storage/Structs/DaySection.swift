//
//  DaySection.swift
//  CoinTail
//
//  Created by Eugene on 11.07.23.
//

import Foundation


struct DaySectionTransferHistory {
    var day: Date
    var transfers: [TransferHistoryClass]
    
    static func groupTransfers(groupTransfers: [TransferHistoryClass]) -> [DaySectionTransferHistory] {
        let dictionary = Dictionary.init(grouping: groupTransfers) { transfer in
            transfer.date.firstDayOfPeriod(components: [.year, .month, .day])
        }.map { values in
            DaySectionTransferHistory(day: values.key, transfers: values.value)
        }
        
        return dictionary
    }
}
