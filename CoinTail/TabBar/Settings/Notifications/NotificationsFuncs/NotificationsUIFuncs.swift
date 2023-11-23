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
        self.view.addSubview(notificationsTitleLabel)
        self.view.addSubview(notificationsDescriptionLabel)
        self.view.addSubview(notificationsCV)

        bellImageView.easy.layout([
            Height(100),
            Width(100),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            CenterX()
        ])
        
        notificationsTitleLabel.easy.layout([
            Top(24).to(bellImageView, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        notificationsDescriptionLabel.easy.layout([
            Top(16).to(notificationsTitleLabel, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        notificationsCV.easy.layout([
            Top(32).to(notificationsDescriptionLabel, .bottom),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom),
            CenterX(),
            Left(16),
            Right(16)
        ])
    }
    
}
