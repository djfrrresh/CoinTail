//
//  HomeCVFuncs.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


extension HomeVC {
    
    // Отсортировать массив операций по месяцам (убывание)
    func filterMonths() {
        monthSections = MonthSection.group(groupRecords: Records.shared.records[segment]!)
        monthSections.sort { l, r in
            return l.month > r.month
        }
    }
    
}
