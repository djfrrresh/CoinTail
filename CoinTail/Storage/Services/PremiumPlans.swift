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
            period: "month".localized()
        ),
        PlanData(
            title: "Year".localized(),
            price: 1290,
            buyButtonTitle: "Start free trial".localized(),
            period: "year".localized(),
            isTrial: true,
            trialDaysInt: 3,
            promoText: "3 free days".localized()
        )
    ]
    
}
