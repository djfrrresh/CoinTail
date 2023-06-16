//
//  RecordStruct.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit


// Структура операции
struct Record: Equatable {
    var amount: Double
    var descriptionText: String = ""
    var date: Date
    var id: Int
    var type: RecordType
    var category: Category
}

enum RecordType: String {
    case expense = "Expense"
    case income = "Income"
    case allOperations = "Total"
}
