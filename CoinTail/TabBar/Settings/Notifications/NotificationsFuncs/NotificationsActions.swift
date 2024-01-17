//
//  NotificationsActions.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
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
    
    @objc func switchToggled(toggle: UISwitch) {
        if toggle.isOn {
            // Запрос на подключение уведомлений
            notificationCenter.requestAuthorization(options: [.alert, .badge ,.sound]) { [weak self] granted, _ in

                guard let strongSelf = self else { return }

                guard granted else {
                    DispatchQueue.main.async {
                        strongSelf.notificationsPermission()

                        toggle.isOn = false
                    }
                    return
                }

                // Проверка доступа к уведомлениям у пользователя
                strongSelf.notificationCenter.getNotificationSettings { settings in
                    guard settings.authorizationStatus == .authorized else { return }
                }

                DispatchQueue.main.async {
                    // Сохранить в настройки приложения вкл/выкл
                    Notifications.shared.toggleStatus = toggle.isOn
                }
            }
            notificationCenter.delegate = self

            let segment = notificationRegularity

            sendNotifications(segment: segment)
        } else {
            // Отключение уведомлений по идентификатору
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["operationNotifications"])

            // Сохранить в настройки приложения положение выключателя
            Notifications.shared.toggleStatus = toggle.isOn
        }
    }
    
    // Проверка на то, включены ли уведомления в настройках
    private func notificationsPermission() {
        confirmationAlert(
            title: "Error".localized(),
            message: "You need to enable notifications in settings".localized(),
            confirmActionTitle: "Go to Settings".localized()
        ) {
            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            if !isRegisteredForRemoteNotifications {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
    }
    
}
