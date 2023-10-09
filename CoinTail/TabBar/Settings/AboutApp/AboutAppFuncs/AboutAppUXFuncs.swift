//
//  AboutAppUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 07.10.23.
//

import UIKit


extension AboutAppVC {
    
    func aboutAppTargets() {
        telegramButton.addTarget(self, action: #selector(telegramAction), for: .touchUpInside)
        gmailButton.addTarget(self, action: #selector(gmailAction), for: .touchUpInside)
    }
    
}
