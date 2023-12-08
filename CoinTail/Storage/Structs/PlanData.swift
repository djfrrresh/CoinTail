//
//  PlanData.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

//import RevenueCat


struct PlanData: Equatable {
    var title = ""
    var price: Int
    var buyButtonTitle = ""
    var period = ""
    var isTrial: Bool
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
//    var package: Package?
}
