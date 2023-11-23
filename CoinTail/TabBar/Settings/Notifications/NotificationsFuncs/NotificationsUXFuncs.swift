//
//  NotificationsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 19.10.23.
//

import UIKit


extension NotificationsVC {
    
    // Проверка доступа к уведомлениям на случай, если юзер выключит их в настройках при включенных уведомлениях на экране
    func notificationsValidate(toggle: UISwitch) {
        notificationCenter.requestAuthorization(options: [.alert, .badge ,.sound]) { granted, _ in
            if !granted {
                DispatchQueue.main.async {
                    toggle.isOn = false

                    Notifications.shared.toggleStatus = false
                }
            }
        }
    }
    
    // Отправка уведомления
    func sendNotifications(segment: NotificationPeriods) {
        let notificationContent: UNMutableNotificationContent = {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Enter all expenses!"
            notificationContent.body = "It's time to make all the transactions!"
            notificationContent.badge = NSNumber(value: 1)
            
            return notificationContent
        }()
        
        var components = DateComponents()
        
        switch notificationRegularity {
        case .daily:
            let dayDateComponents: DateComponents = {
                var dateComponents = DateComponents()
                dateComponents.hour = 20
                dateComponents.minute = 0

                return dateComponents
            }()
            components = dayDateComponents
        case .weekly:
            let weekDateComponents: DateComponents = {
                var dateComponents = DateComponents()
                dateComponents.hour = 20
                dateComponents.minute = 0
                dateComponents.weekday = 1

                return dateComponents
            }()
            components = weekDateComponents
        }
        
        // Триггер по компонентам даты
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: "operationNotifications", content: notificationContent, trigger: trigger)
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription as Any)
        }
    }
    
}
