//
//  RecordStruct.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import Foundation


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
