//
//  PremiumPlans.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
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

import UIKit


class PremiumPlans {
    
    static let shared = PremiumPlans()

    let plans: [PlanData] = [
        PlanData(
            title: "Month".localized(),
            price: 149,
            buyButtonTitle: "Continue - total".localized(),
            period: "month".localized(),
            privacyText: "By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via App Store settings, and you agree to our User Agreement and Privacy Policy.".localized()
        ),
        PlanData(
            title: "Year".localized(),
            price: 1290,
            buyButtonTitle: "Continue - total".localized(),
            period: "year".localized(),
            privacyText: "By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via App Store settings, and you agree to our User Agreement and Privacy Policy.".localized(),
//            privacyText: "After %@, you will be charged, your subscription will auto-renew for the full price and package until you cancel via App Store settings, and you agree to our User Agreement and Privacy Policy.".localized(),
//            isTrial: true,
//            trialDaysInt: 3,
            promoText: "107.50 " + "₽ per month".localized()
        )
    ]
    
}
