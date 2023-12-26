//
//  RecordStruct.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import Foundation
import RealmSwift


class RecordClass: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var amount: Double = 0
    @Persisted var descriptionText: String = ""
    @Persisted var date: Date = Date()
    @Persisted var type: String = ""
    @Persisted var categoryID: ObjectId
    @Persisted var accountID: ObjectId?
    @Persisted var currency: String = ""
}
