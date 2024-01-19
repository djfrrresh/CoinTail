//
//  MonthSection.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation


// Секции по месяцам для операций
struct OperationsDaySection {
    var month: Date
    var records: [RecordClass]
    
    static func groupRecords(section: RecordType, groupRecords: [RecordClass]) -> [OperationsDaySection] {
        let dictionary = Dictionary.init(grouping: groupRecords) { record in
            record.date.firstDayOfPeriod(components: [.year, .month, .day])
        }.map { values in
            let sortedRecords = values.value.sorted(by: { $0.date > $1.date })
            
            return OperationsDaySection(month: values.key, records: sortedRecords)
        }
        
        return dictionary
    }
}
