//
//  AboutAppUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 06.10.23.
//

import UIKit
import EasyPeasy


extension AboutAppVC {
    
    func aboutSubviews() {
        self.view.addSubview(moneyImageView)
        self.view.addSubview(coinTailTitleLabel)
        self.view.addSubview(aboutLabel)
        self.view.addSubview(contactsCV)

        moneyImageView.easy.layout([
            Height(100),
            Width(100),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            CenterX()
        ])
        
        coinTailTitleLabel.easy.layout([
            Top(24).to(moneyImageView, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        aboutLabel.easy.layout([
            Top(16).to(coinTailTitleLabel, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        contactsCV.easy.layout([
            Top(24).to(aboutLabel, .bottom),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom),
            Left(16),
            Right(16),
            CenterX()
        ])
        
        chevronImageView.easy.layout([
            Right(16),
            CenterY(),
            Height(20),
            Width(20)
        ])
    }
    
}
