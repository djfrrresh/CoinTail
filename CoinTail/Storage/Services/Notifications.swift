//
//  Notifications.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
//

import Foundation
import RealmSwift


class Notifications {
    
    static let shared = Notifications()
    
    private let realmService = RealmService.shared

    // Вкл / выкл
    var toggleStatus: Bool {
        get {
            return realmService.read(NotificationSettingsClass.self).first?.toggleStatus ?? false
        }
        set {
            // Если объект уже есть, заменить данные внутри него на новые
            if let settings = realmService.read(NotificationSettingsClass.self).first {
                realmService.realm?.beginWrite() // Начало блока записи
                settings.toggleStatus = newValue // Изменение свойства внутри блока записи
                
                do {
                    try realmService.realm?.commitWrite() // Завершение блока записи
                } catch {
                    print("Error updating toggleStatus: \(error)")
                }
                // Иначе создать новый объект
            } else {
                let newSettings = NotificationSettingsClass()
                newSettings.toggleStatus = newValue
                
                realmService.write(newSettings, NotificationSettingsClass.self)
            }
        }
    }

    // Выбранный период
    var regularity: NotificationPeriods {
        get {
            if let stringValue = realmService.read(NotificationSettingsClass.self).first?.regularity,
               let period = NotificationPeriods(rawValue: stringValue) {
                return period
            }
            return .daily
        }
        set {
            let stringValue = newValue.rawValue
            if let settings = realmService.read(NotificationSettingsClass.self).first {
                realmService.realm?.beginWrite()
                settings.regularity = stringValue
                
                do {
                    try realmService.realm?.commitWrite()
                } catch {
                    print("Error updating toggleStatus: \(error)")
                }
            } else {
                let newSettings = NotificationSettingsClass()
                newSettings.regularity = stringValue
                realmService.write(newSettings, NotificationSettingsClass.self)
            }
        }
    }
    
}
