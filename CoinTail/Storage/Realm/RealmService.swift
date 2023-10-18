//
//  RealmService.swift
//  CoinTail
//
//  Created by Eugene on 12.10.23.
//

import Foundation
import RealmSwift


protocol RealmFuncs: AnyObject {
    func addRecord(_ record: Record)
    func read()
    func update()
    func delete()
}

class RealmService: RealmFuncs {
    
    static let shared = RealmService()
    
    private(set) var realm: Realm?
    
    let records: [RecordClass] = []
    
    private init() {
        realmInit()
    }
    
    func addRecord() {
        <#code#>
    }
    
    func read() {
        <#code#>
    }
    
    func update() {
        <#code#>
    }
    
    func delete() {
        <#code#>
    }
    
    private func realmInit() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            
            realm = try Realm()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}
