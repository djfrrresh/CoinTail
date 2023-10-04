//
//  Notifications.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
//

import UIKit


class Notifications {
    
    static let shared = Notifications()

    // Вкл / выкл
    var toggleStatus: Bool = false
    
    // Выбранный период
    var periodSwitcher: NotificationPeriods = .day
    
}
