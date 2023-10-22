//
//  TransferHistory.swift
//  CoinTail
//
//  Created by Eugene on 11.09.23.
//

import RealmSwift


class TransferHistoryClass: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var sourceAccount: String = ""
    @Persisted var targetAccount: String = ""
    @Persisted var amount: Double = 0
    @Persisted var date: Date = Date()
}
