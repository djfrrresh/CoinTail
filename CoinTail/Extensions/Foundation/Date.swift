//
//  Date.swift
//  CoinTail
//
//  Created by Eugene on 28.08.23.
//

import Foundation


extension Date {
    
    // Получение первого дня указанного периода
    func firstDayOfPeriod(components: Set<Calendar.Component>) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents(components, from: self)
        
        return calendar.date(from: components)!
    }
    
}
