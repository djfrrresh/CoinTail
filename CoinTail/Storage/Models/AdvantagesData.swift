//
//  AdvantagesData.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

import Foundation


struct AdvantagesData {
    var descriptionText: String = ""
    var icon: String = ""
    
    static var advantages: [AdvantagesData] = [
        AdvantagesData(descriptionText: "Access to all currencies".localized(), icon: "💱"),
        AdvantagesData(descriptionText: "Access to informative diagrams".localized(), icon: "📊"),
        AdvantagesData(descriptionText: "Unlimited accounts".localized(), icon: "🏦"),
        AdvantagesData(descriptionText: "Unlimited budgets".localized(), icon: "🎯"),
        AdvantagesData(descriptionText: "Ability to add sub-categories".localized(), icon: "🗂"),
        AdvantagesData(descriptionText: "A cup of coffee for the developer".localized(), icon: "☕️")
    ]
}
