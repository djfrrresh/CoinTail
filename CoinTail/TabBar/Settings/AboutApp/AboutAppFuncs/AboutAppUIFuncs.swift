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
        self.view.addSubview(appVersionView)
        self.view.addSubview(userAgreementButton)
        self.view.addSubview(contactsCV)

        appVersionView.addSubview(appVersionTextLabel)
        appVersionView.addSubview(appVersionLabel)
        
        userAgreementButton.addSubview(userAgreementLabel)
        userAgreementButton.addSubview(chevronImageView)

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
        
        appVersionView.easy.layout([
            Height(72),
            Left(16),
            Right(16),
            Top(32).to(aboutLabel, .bottom),
            CenterX()
        ])
        
        appVersionTextLabel.easy.layout([
            Left(16),
            Right(16),
            Top(12)
        ])
        
        appVersionLabel.easy.layout([
            Left(16),
            Right(16),
            Bottom(12)
        ])
        
        userAgreementButton.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top(24).to(appVersionView, .bottom),
            Height(44)
        ])
        
        contactsCV.easy.layout([
            Top(24).to(userAgreementButton, .bottom),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom),
            Left(16),
            Right(16),
            CenterX()
        ])
        
        userAgreementLabel.easy.layout([
            Left(16),
            CenterY()
        ])
        
        chevronImageView.easy.layout([
            Right(16),
            CenterY(),
            Height(20),
            Width(20)
        ])
    }
    
}
