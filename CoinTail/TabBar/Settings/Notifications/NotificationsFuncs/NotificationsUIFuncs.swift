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
        self.view.addSubview(backView)

        backView.addSubview(onOffToggle)
        backView.addSubview(onOffLabel)
        backView.addSubview(notificationsSwitcher)
        backView.addSubview(periodLabel)
        
        backView.easy.layout([
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            Left(16),
            Right(16),
            Height(120)
        ])
        
        onOffToggle.easy.layout([
            Right(16),
            Top(16)
        ])
        
        onOffLabel.easy.layout([
            Left(16),
            CenterY().to(onOffToggle)
        ])
        
        notificationsSwitcher.easy.layout([
            Bottom(16),
            Height(32),
            Right(16)
        ])
        
        periodLabel.easy.layout([
            Left(16),
            CenterY().to(notificationsSwitcher)
        ])
    }
    
    func currentNotificationSegment() {
        if notificationSegment == .day {
            Notifications.shared.periodSwitcher = .day
            notificationsSwitcher.selectedSegmentIndex = 0
        } else {
            Notifications.shared.periodSwitcher = .week
            notificationsSwitcher.selectedSegmentIndex = 1
        }
    }
    
}
