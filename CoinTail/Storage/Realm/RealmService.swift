//
//  RealmService.swift
//  CoinTail
//
//  Created by Eugene on 12.10.23.
//

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
        DispatchQueue.main.async { [self] in
            do {
                try realm?.write({
                    realm?.add(object)
                })
            } catch let error {
                print(error)
            }
            
            RealmService.shared.readAll(type)
        }
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
        default:
            fatalError()
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
        DispatchQueue.main.async { [self] in
            do {
                try realm?.write {
                    realm?.add(object, update: .modified)
                }
            } catch let error {
                print(error)
            }
            
            if type != NotificationSettingsClass.self && type != SelectedCurrencyClass.self {
                RealmService.shared.readAll(type)
            }
        }
    }
    
    func delete<T: Object>(_ object: T, _ type: T.Type) {
        DispatchQueue.main.async { [self] in
            do {
                try realm?.write {
                    realm?.delete(object)
                }
            } catch let error {
                print(error)
            }
            
            RealmService.shared.readAll(type)
        }
    }
    
    func deleteAllObjects<T: Object>(_ type: T.Type) {
        DispatchQueue.main.async { [self] in
            guard let objects = realm?.objects(type) else { return }
            
            do {
                try realm?.write {
                    realm?.delete(objects)
                }
            } catch let error {
                print(error)
            }
            
            if type != NotificationSettingsClass.self && type != SelectedCurrencyClass.self {
                RealmService.shared.readAll(type)
            }
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
            print(error.localizedDescription)
        }
        
    }
    
}
