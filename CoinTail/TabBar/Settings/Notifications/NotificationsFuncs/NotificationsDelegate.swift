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
        completionHandler([.alert, .sound])
        
        print(#function)
    }
    
    // TODO: сделать перенос на экран с добавлением операции
    // Срабатывает при нажатии на уведомление
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
    
}
