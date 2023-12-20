//
//  PremiumPlans.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

import UIKit


class PremiumPlans {
    
    static let shared = PremiumPlans()

    let plans: [PlanData] = [
        PlanData(
            title: "Month".localized(),
            price: 149,
            buyButtonTitle: "Continue - total".localized(),
            period: "month".localized(),
            privacyText: "By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via App Store settings, and you agree to our Terms, User Agreement and Privacy Policy.".localized()
        ),
        PlanData(
            title: "Year".localized(),
            price: 1290,
            buyButtonTitle: "Start free trial".localized(),
            period: "year".localized(),
            privacyText: "After %@, you will be charged, your subscription will auto-renew for the full price and package until you cancel via App Store settings, and you agree to our Terms, User Agreement and Privacy Policy.".localized(),
            isTrial: true,
            trialDaysInt: 3,
            promoText: "3 free days".localized()
        )
    ]
    
}
