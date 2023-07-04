//
//  MonthSection.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


struct MonthSection {
    var month: Date
    var records: [Record]
    
    static func group(section: RecordType, groupRecords: [Record]) -> [MonthSection] {
        let dictionary = Dictionary.init(grouping: groupRecords) { record in
            firstDayOfMonth(date: record.date)
        }.map { values in
            MonthSection(month: values.key, records: values.value)
        }
        return dictionary
    }
    
    static func firstDayOfMonth(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
}
