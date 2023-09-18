//
//  Notifications.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
//

import UIKit


class Notifications {
    
    static let shared = Notifications()

    var toggleStatus: Bool = false
    
    var periodSwitcher: NotificationPeriods = .day
    
}
