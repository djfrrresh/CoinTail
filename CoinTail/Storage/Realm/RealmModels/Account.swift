//
//  Account.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import Foundation
import RealmSwift


class AccountClass: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String = ""
    @Persisted var startBalance: Double = 0
    @Persisted var amountBalance: Double = 0
    @Persisted var currency: String = ""
}
