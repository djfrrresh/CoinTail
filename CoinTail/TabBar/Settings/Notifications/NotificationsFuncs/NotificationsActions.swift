//
//  NotificationsActions.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
//

import UIKit


extension NotificationsVC {
    
    @objc func toggleChanged(toggle: UISwitch) {
        if onOffToggle.isOn {
            // Запрос на подключение уведомлений
            notificationCenter.requestAuthorization(options: [.alert, .badge ,.sound]) { [weak self] granted, _ in
                
                guard let strongSelf = self else { return }
                
                guard granted else {
                    DispatchQueue.main.async {
                        strongSelf.permissonAlert()
                        
                        strongSelf.onOffToggle.isOn = false
                    }
                    return
                }
                
                // Проверка доступа к уведомлениям у пользователя
                strongSelf.notificationCenter.getNotificationSettings { settings in
                    guard settings.authorizationStatus == .authorized else { return }
                }
                
                DispatchQueue.main.async {
                    // Сохранить в настройки приложения вкл/выкл
                    Notifications.shared.toggleStatus = strongSelf.onOffToggle.isOn
                }
            }
            notificationCenter.delegate = self

            let segment = NotificationPeriods(rawValue: notificationsSwitcher.titleForSegment(at: notificationsSwitcher.selectedSegmentIndex)!) ?? .day
            
            sendNotifications(segment: segment)
        } else {
            // Отключение уведомлений по идентификатору
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["operationNotifications"])
            
            Notifications.shared.toggleStatus = onOffToggle.isOn
        }
    }
    
    @objc func savePeriod() {
        notificationSegment = NotificationPeriods(rawValue: notificationsSwitcher.titleForSegment(at: notificationsSwitcher.selectedSegmentIndex) ?? "Day") ?? .day
        
        // Сохранить в настройки приложения период
        Notifications.shared.periodSwitcher = notificationSegment
    }
    
    private func permissonAlert() {
        let settingsAction = UIAlertAction(title: "Go to Settings", style: .default) { _ in
            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            if !isRegisteredForRemoteNotifications {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        let alertView = UIAlertController(title: "Error", message: "You need to enable notifications in settings", preferredStyle: .alert)
        
        alertView.addAction(settingsAction)
        alertView.addAction(cancelAction)
        
        self.present(alertView, animated: true)
    }
    
}
