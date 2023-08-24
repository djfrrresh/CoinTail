//
//  Budget.swift
//  CoinTail
//
//  Created by Eugene on 30.06.23.
//

import UIKit


struct Budget: Equatable {
    var category: Category
    var amount: Double
    var startDate: Date
    var untilDate: Date
    var id: Int
    var segmentIndex: Int
}
