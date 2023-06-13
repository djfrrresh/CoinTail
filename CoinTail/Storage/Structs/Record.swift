//
//  RecordStruct.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit


// Структура операции
struct Record {
    var amount: Double
    var descriptionText: String = ""
    var categoryText: String = ""
    var categoryImage: UIImage
    var date: Date
    var id: Int
    var type: RecordType
    var categoryColor: UIColor
}

enum RecordType: String {
    case expense = "Expense"
    case income = "Income"
    case allOperations = "Total"
}
