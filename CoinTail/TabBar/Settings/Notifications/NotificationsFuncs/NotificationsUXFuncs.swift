//
//  NotificationsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 19.10.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
            notificationContent.title = "Enter all expenses!".localized()
            notificationContent.body = "It's time to make all the transactions!".localized()
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
