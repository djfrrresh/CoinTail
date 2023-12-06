//
//  PremiumUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

import UIKit
import EasyPeasy


extension PremiumVC {
    
    func premiumSubviews() {
        self.view.addSubview(buttonBackground)
        self.view.addSubview(premiumCV)
        
        buttonBackground.addSubview(buyPremiumButton)
        
        buttonBackground.easy.layout([
            Bottom(68).to(self.view.safeAreaLayoutGuide, .bottom),
            Height(150),
            Left(),
            Right()
        ])
        
        buyPremiumButton.easy.layout([
            Left(16),
            Right(16),
            Center(),
            Height(52)
        ])
    }
    
}
