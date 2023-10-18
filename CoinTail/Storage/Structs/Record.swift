//
//  RecordStruct.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import Foundation
import RealmSwift


struct Record: Equatable {
    var amount: Double
    var descriptionText: String = ""
    var date: Date
    var id: Int
    var type: RecordType
    var categoryID: Int
    var accountID: Int?
    var currency: Currency
}

class RecordClass: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var amount: Double = 0
    @Persisted var descriptionText: String = ""
    @Persisted var date: Date = Date()
    @Persisted var type: String = ""
    @Persisted var categoryID: ObjectId
    @Persisted var accountID: ObjectId
    @Persisted var currency: String = ""
}
