//
//  PrivacyLink.swift
//  CoinTail
//
//  Created by Eugene on 20.12.23.
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

import Foundation


struct PrivacyLink: Hashable {
    let url: String
    let internalType: Int
    let localizationKey: String
    
    enum LinkType: Int {
        case eula = 1
        case privacy = 2
    }
    
    var type: LinkType {
        LinkType(rawValue: internalType) ?? .eula
    }
}

struct Privacy {
    let premiumLinks: [PrivacyLink]
    let aboutLink: PrivacyLink
    
    static var privacy: Privacy {
        let currentLocalization = Bundle.main.preferredLocalizations.first ?? "en"

        var privacyPolicyURL = ""
        var userAgreementURL = ""

        // Выбор перевода в зависимости от языка системы пользователя
        switch currentLocalization {
        case "ru":
            privacyPolicyURL = "https://docs.google.com/document/d/1ySZEggizST7attJrnqCeDutQC15lup11b0v5NwC7m2I/edit?usp=sharing"
            userAgreementURL = "https://docs.google.com/document/d/1yiNMDxz63Ek_gqnuS21mZm63UMU1ocS4kXynTg4KNDI/edit?usp=sharing"
        default:
            privacyPolicyURL = "https://docs.google.com/document/d/1SP_zA5S4noMnV-wfrGdeFKIzFCb0nQbsAdveshKV4Mw/edit?usp=sharing"
            userAgreementURL = "https://docs.google.com/document/d/19UmcCXu_mDZkuzytpAtUv0OIWKm5mHBe0SS2qC3B6B0/edit?usp=sharing"
        }

        return Privacy(
            premiumLinks: [
                PrivacyLink(url: userAgreementURL, internalType: 1, localizationKey: "User Agreement"),
                PrivacyLink(url: privacyPolicyURL, internalType: 2, localizationKey: "Privacy Policy")
            ],
            aboutLink: PrivacyLink(url: userAgreementURL, internalType: 1, localizationKey: "User Agreement")
        )
    }
}
