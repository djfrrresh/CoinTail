//
//  PrivacyLink.swift
//  CoinTail
//
//  Created by Eugene on 20.12.23.
//

import Foundation


struct PrivacyLink: Hashable {
    let url: String
    let internalType: Int
    let localizationKey: String
    
    enum LinkType: Int {
        case eula = 1
        case privacy = 2
        case tos = 3
    }
    
    var type: LinkType {
        LinkType(rawValue: internalType) ?? .tos
    }
}

struct Privacy {
    let premiumLinks: [PrivacyLink]
    let aboutLink: PrivacyLink
    
    static var privacy: Privacy = Privacy(
        premiumLinks: [
            PrivacyLink(url: "https://www.youtube.com/", internalType: 1, localizationKey: "User Agreement"),
            PrivacyLink(url: "https://translate.google.com/?hl=ru&sl=ru&tl=en&op=translate", internalType: 2, localizationKey: "Privacy Policy"),
            PrivacyLink(url: "https://vk.com/feed", internalType: 3, localizationKey: "Terms")
        ],
        aboutLink: PrivacyLink(url: "https://www.youtube.com/", internalType: 1, localizationKey: "User Agreement")
    )
}
