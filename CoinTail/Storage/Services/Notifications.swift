//
//  Notifications.swift
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
