//
//  Account.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import Foundation


struct Account: Equatable {
    var id: Int
    var name: String
    var startBalance: Double
    var amountBalance: Double = 0
    var currency: Currency
}
