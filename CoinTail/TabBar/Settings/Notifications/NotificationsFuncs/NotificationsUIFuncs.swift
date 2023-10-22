//
//  NotificationsUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
//

import UIKit
import EasyPeasy


extension NotificationsVC {
    
    func notificationsSubviews() {
        self.view.addSubview(bellImageView)
        self.view.addSubview(largeTitleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(notificationsCV)

        bellImageView.easy.layout([
            Height(100),
            Width(100),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            CenterX()
        ])
        
        largeTitleLabel.easy.layout([
            Top(24).to(bellImageView, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        descriptionLabel.easy.layout([
            Top(16).to(largeTitleLabel, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        notificationsCV.easy.layout([
            Top(32).to(descriptionLabel, .bottom),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom),
            CenterX(),
            Left(16),
            Right(16)
        ])
    }
    
}
