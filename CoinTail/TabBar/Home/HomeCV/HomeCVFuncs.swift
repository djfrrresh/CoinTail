//
//  HomeCVFuncs.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


extension HomeVC {
    
    func filterMonths() {
        let getRecord = Records.shared.getRecords(for: period, type: homeSegment, step: currentStep, category: categorySort)
        
        Categories.shared.categoriesUpdate(records: getRecord)
        
        categoriesArr = Categories.shared.getCategories(for: homeSegment)
        monthSections = MonthSection.groupRecords(section: homeSegment, groupRecords: getRecord)
        
        balanceLabel.text = "Total: $\(Records.shared.getAmount(for: .allTheTime, type: .allOperations))"
    
        // Отсортировать массив операций по месяцам (убывание)
        monthSections.sort { l, r in
            return l.month > r.month
        }
    }
    
}
