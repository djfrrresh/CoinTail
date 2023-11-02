//
//  FavouriteCurrency.swift
//  CoinTail
//
//  Created by Eugene on 23.10.23.
//

import Foundation
import RealmSwift


class FavouriteCurrencyClass: Object {
    @Persisted(primaryKey: true) var id: ObjectId

    @Persisted var currency: String = ""
}
