//
//  RealmService.swift
//  CoinTail
//
//  Created by Eugene on 12.10.23.
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


final class RealmService {
    
    static let shared = RealmService()
        
    private(set) var realm: Realm?
    
    // Здесь хранятся все объекты классов из базы данных
    var transfersHistoryArr: [TransferHistoryClass] = []
    var accountsArr: [AccountClass] = []
    var budgetsArr: [BudgetClass] = []
    var recordsArr: [RecordClass] = []
    var categoriesArr: [CategoryClass] = []
    var subcategoriesArr: [SubcategoryClass] = []
    var favouriteCurrenciesArr: [FavouriteCurrencyClass] = []

    private init() {
        realmInit()
    }
    
    func write<T: Object>(_ object: T, _ type: T.Type) {
        do {
            try realm?.write({
                realm?.add(object)
            })
        } catch let error {
            SentryManager.shared.capture(error: "Error: realm write \(error.localizedDescription)", level: .error)
            print(error)
        }
        
        RealmService.shared.readAll(type)
    }
    
    func read<T: Object>(_ object: T.Type) -> [T] {
        return realm?.objects(object).map { $0 } ?? []
    }
    
    func readAll<T: Object>(_ object: T.Type) {
        switch "\(object)" {
        case "TransferHistoryClass":
            transfersHistoryArr.removeAll()
        case "AccountClass":
            accountsArr.removeAll()
        case "BudgetClass":
            budgetsArr.removeAll()
        case "RecordClass":
            recordsArr.removeAll()
        case "CategoryClass":
            categoriesArr.removeAll()
        case "SubcategoryClass":
            subcategoriesArr.removeAll()
        case "NotificationSettingsClass":
            return
        case "SelectedCurrencyClass":
            return
        case "FavouriteCurrencyClass":
            favouriteCurrenciesArr.removeAll()
        case "PremiumStatusClass":
            return
        default:
            SentryManager.shared.capture(error: "Error when trying to read all realm objects", level: .fatal)
            fatalError("Error when trying to read all realm objects")
        }
        
        if let objects = realm?.objects(object.self).map({$0}) {
            for object in objects {
                switch object {
                case let transfersHistory as TransferHistoryClass:
                    transfersHistoryArr.append(transfersHistory)
                case let account as AccountClass:
                    accountsArr.append(account)
                case let budget as BudgetClass:
                    budgetsArr.append(budget)
                case let record as RecordClass:
                    recordsArr.append(record)
                case let category as CategoryClass:
                    categoriesArr.append(category)
                case let subcategory as SubcategoryClass:
                    subcategoriesArr.append(subcategory)
                case let favouriteCurrency as FavouriteCurrencyClass:
                    favouriteCurrenciesArr.append(favouriteCurrency)
                default:
                    fatalError()
                }
            }
        }
    }
    
    func update<T: Object>(_ object: T, _ type: T.Type) {
        do {
            try realm?.write {
                realm?.add(object, update: .modified)
            }
        } catch let error {
            SentryManager.shared.capture(error: "Error: realm update \(error.localizedDescription)", level: .error)
            print(error)
        }
        
        if type != NotificationSettingsClass.self && 
            type != SelectedCurrencyClass.self &&
            type != PremiumStatusClass.self {
            RealmService.shared.readAll(type)
        }
    }
    
    func delete<T: Object>(_ object: T, _ type: T.Type) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch let error {
            SentryManager.shared.capture(error: "Error: realm delete \(error.localizedDescription)", level: .error)
            print(error)
        }
        
        RealmService.shared.readAll(type)
    }
    
    func deleteAllObjects<T: Object>(_ type: T.Type) {
        guard let objects = realm?.objects(type) else { return }
        
        do {
            try realm?.write {
                realm?.delete(objects)
            }
        } catch let error {
            SentryManager.shared.capture(error: "Error: realm delete all objects \(error.localizedDescription)", level: .error)
            print(error)
        }
        
        if type != NotificationSettingsClass.self && 
            type != SelectedCurrencyClass.self &&
            type != PremiumStatusClass.self {
            RealmService.shared.readAll(type)
        }
    }
    
    func readAllClasses() {
        RealmService.shared.readAll(AccountClass.self)
        RealmService.shared.readAll(TransferHistoryClass.self)
        RealmService.shared.readAll(BudgetClass.self)
        RealmService.shared.readAll(RecordClass.self)
        RealmService.shared.readAll(CategoryClass.self)
        RealmService.shared.readAll(SubcategoryClass.self)
        RealmService.shared.readAll(FavouriteCurrencyClass.self)
    }
    
    func deleteAllData() {
        deleteAllObjects(AccountClass.self)
        deleteAllObjects(TransferHistoryClass.self)
        deleteAllObjects(BudgetClass.self)
        deleteAllObjects(RecordClass.self)
        deleteAllObjects(CategoryClass.self)
        deleteAllObjects(SubcategoryClass.self)
        deleteAllObjects(NotificationSettingsClass.self)
        deleteAllObjects(SelectedCurrencyClass.self)
        deleteAllObjects(FavouriteCurrencyClass.self)
    }
    
    private func realmInit() {
        do {
            // Запись, необходимая для миграции данных
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            
            realm = try Realm()
        } catch let error {
            SentryManager.shared.capture(error: "Error: realm init \(error.localizedDescription)", level: .error)
            print(error.localizedDescription)
        }
        
    }
    
}
