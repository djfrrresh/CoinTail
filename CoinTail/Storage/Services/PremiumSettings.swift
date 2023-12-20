//
//  PremiumSettings.swift
//  CoinTail
//
//  Created by Eugene on 15.12.23.
//

import Foundation


struct PremiumSettings: Decodable {
    let enabled: Bool
    var isPremiumActive: Bool = false
    var premiumActiveUntil: Int64?
    
    var expirationDate: Date? {
        guard let expirationDateUnix = premiumActiveUntil else { return nil }
        
        return Date(timeIntervalSince1970: TimeInterval(expirationDateUnix))
    }
    
    var stillActive: Bool {
        guard let expirationDate = expirationDate else { return false }
        
        return expirationDate > Date()
    }
    
    enum CodingKeys: String, CodingKey {
        case enabled
        case isPremiumActive = "is_premium_active"
        case premiumActiveUntil = "premium_active_until"
    }
}
