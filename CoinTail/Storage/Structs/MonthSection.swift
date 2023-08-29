//
//  MonthSection.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


// Секции по месяцам для операций
struct MonthSection {
    var month: Date
    var records: [Record]
    
    static func groupRecords(section: RecordType, groupRecords: [Record]) -> [MonthSection] {
        let dictionary = Dictionary.init(grouping: groupRecords) { record in
            record.date.firstDayOfPeriod(components: [.year, .month])
        }.map { values in
            MonthSection(month: values.key, records: values.value)
        }
        return dictionary
    }
}
