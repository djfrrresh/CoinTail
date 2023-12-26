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
        self.view.addSubview(aboutImageView)
        self.view.addSubview(aboutTitleLabel)
        self.view.addSubview(accountsDescriptionLabel)
        self.view.addSubview(contactsCV)

        aboutImageView.easy.layout([
            Height(100),
            Width(100),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            CenterX()
        ])
        
        aboutTitleLabel.easy.layout([
            Top(24).to(aboutImageView, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        accountsDescriptionLabel.easy.layout([
            Top(16).to(aboutTitleLabel, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        contactsCV.easy.layout([
            Top(24).to(accountsDescriptionLabel, .bottom),
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
