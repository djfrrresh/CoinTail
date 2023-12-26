//
//  SubscriptionPeriod.swift
//  CoinTail
//
//  Created by Eugene on 14.12.23.
//

import RevenueCat


extension SubscriptionPeriod {
    
    var localized: String {
//        var postfix: String
//
//        if value == 1 {
//            postfix = ""
//        } else if value < 5 {
//            postfix = "_genitive"
//        } else {
//            postfix = "_plural"
//        }
        
        switch unit {
        case .day:
            return "\(value)" + "day"
        case .week:
            return "\(value)" + "week"
        case .month:
            return "\(value)" + "month"
        case .year:
            return "\(value)" + "year"
        }
    }
    
}
