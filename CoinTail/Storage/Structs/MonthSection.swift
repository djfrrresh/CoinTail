//
//  MonthSection.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import Foundation


// Секции по месяцам для операций
struct MonthSection {
    var month: Date
    var records: [RecordClass]
    
    static func groupRecords(section: RecordType, groupRecords: [RecordClass]) -> [MonthSection] {
        let dictionary = Dictionary.init(grouping: groupRecords) { record in
            record.date.firstDayOfPeriod(components: [.year, .month])
        }.map { values in
            MonthSection(month: values.key, records: values.value)
        }
        
        return dictionary
    }
}
