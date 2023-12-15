//
//  PlanData.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

import RevenueCat


struct PlanData: Equatable {
    var title = ""
    var price: Int
    var buyButtonTitle = ""
    var period = ""
    var description = ""
    var isTrial: Bool = false
//    {
//        get {
//            if AppSettings.shared.premiumDisplay == .tcs {
//                return false
//            } else {
//                return promoText != nil
//            }
//        }
//    }
    var trialDaysInt: Int?
    var promoText: String?
    var package: Package?
    
    static func == (lhs: PlanData, rhs: PlanData) -> Bool {
        return lhs.package == rhs.package
        && lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.buyButtonTitle == rhs.buyButtonTitle
        && lhs.promoText == rhs.promoText
    }
}
