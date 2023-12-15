//
//  AppSettings.swift
//  CoinTail
//
//  Created by Eugene on 15.12.23.
//

import UIKit


enum PremiumDisplay {
    case none
    case revenueCat
}

class AppSettings {
    
    static let shared = AppSettings()
    
    var premiumDisplay: PremiumDisplay?
    
    var premium: PremiumSettings? {
        didSet {
//            if premium?.enabled ?? true {
                premiumDisplay = .revenueCat
//            } else {
//                premiumDisplay = .none
//            }
        }
    }
                
//    var privacy: Privacy? // под вопросом
    
}
