//
//  HomeCVFuncs.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


extension HomeVC {
    
    func filterMonths() {
        categoriesArr = Categories.shared.getCategories(for: homeSegment)
        monthSections = MonthSection.group(section: homeSegment)

        // Отсортировать массив операций по месяцам (убывание)
        monthSections.sort { l, r in
            return l.month > r.month
        }
    }
    
}
