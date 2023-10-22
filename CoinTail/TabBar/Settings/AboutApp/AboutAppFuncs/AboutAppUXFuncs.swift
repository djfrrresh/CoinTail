//
//  AboutAppUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import UIKit


extension AboutAppVC {
    
    func aboutTargets() {
        userAgreementButton.addTarget(self, action: #selector(userAgreementAction), for: .touchUpInside)
    }
    
}
