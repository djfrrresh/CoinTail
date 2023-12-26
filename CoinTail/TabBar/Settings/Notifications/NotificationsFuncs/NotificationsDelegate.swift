//
//  NotificationsDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
//

import UIKit
import NotificationCenter


extension NotificationsVC: UNUserNotificationCenterDelegate {
    
    // Получение уведомления при открытом приложении
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound])        
    }
    
    // Срабатывает при нажатии на уведомление
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let vc = AddOperationVC(segmentIndex: 0)
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
