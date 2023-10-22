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

    private init() {
        realmInit()
    }
    
    func write<T: Object>(_ object: T, _ type: T.Type) {
        do {
            try realm?.write({
                realm?.add(object)
            })
        } catch let error {
            print(error)
        }
        
        RealmService.shared.read(type)
    }
    
    func read<T: Object>(_ object: T.Type) {
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
            print(error)
        }
        
        RealmService.shared.read(type)
    }
    
    func delete<T: Object>(_ object: T, _ type: T.Type) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch let error {
            print(error)
        }
        
        RealmService.shared.read(type)
    }
    
    func readAllClasses() {
        RealmService.shared.read(AccountClass.self)
        RealmService.shared.read(TransferHistoryClass.self)
        RealmService.shared.read(BudgetClass.self)
        RealmService.shared.read(RecordClass.self)
        RealmService.shared.read(CategoryClass.self)
        RealmService.shared.read(SubcategoryClass.self)
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
