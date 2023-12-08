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
        self.view.addSubview(buttonBackgroundView)
        self.view.addSubview(premiumCV)
        self.view.addSubview(premiumNavBarView)
        
        buttonBackgroundView.addSubview(buyPremiumButton)
        
        premiumStackView.addArrangedSubview(premiumAppName)
        premiumStackView.addArrangedSubview(premiumLabel)
        
        premiumNavBarView.addSubview(premiumStackView)
        premiumNavBarView.addSubview(navBarButton)
        
        navBarButton.easy.layout([
            Left(16),
            CenterY()
        ])

        premiumStackView.easy.layout([
            Center()
        ])
        
        premiumNavBarView.easy.layout([
            Top().to(view.safeAreaLayoutGuide, .top),
            Left(),
            Right(),
            Height(44)
        ])
        
        premiumCV.easy.layout([
            Top().to(premiumNavBarView),
            Left(),
            Right(),
            Bottom().to(buttonBackgroundView)
        ])
        
        let bottomIndent: CGFloat = UIDevice.current.hasNotch ? 50 : 16
        let buttonBackgroundViewHeight: CGFloat = 54 + 16 + bottomIndent
        
        buttonBackgroundView.easy.layout([
            Bottom(),
            Left(),
            Right(),
            Height(buttonBackgroundViewHeight)
        ])
        
        buyPremiumButton.easy.layout([
            Top(16),
            Left(16),
            Height(54),
            Right(16)
        ])
    }
    
}
