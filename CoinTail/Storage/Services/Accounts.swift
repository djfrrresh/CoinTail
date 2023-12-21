//
//  Accounts.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit
import RealmSwift


final class Accounts {
    
    static let shared = Accounts()
    
    var accounts: [AccountClass] {
        get {
            return RealmService.shared.accountsArr
        }
    }
        
    // Добавить счет
    func addNewAccount(_ account: AccountClass) {
        RealmService.shared.write(account, AccountClass.self)
    }
    
    // Получить счет по его ID
    func getAccount(for id: ObjectId) -> AccountClass? {
        return accounts.filter { $0.id == id }.first
    }
    
    // Получить счет по его имени
    func getAccount(for name: String) -> AccountClass? {
        return accounts.filter { $0.name == name }.last
    }
    
    // Отредактировать счет по его ID
    func editAccount(replacingAccount: AccountClass, completion: ((Bool) -> Void)? = nil) {
        RealmService.shared.update(replacingAccount, AccountClass.self)
        
        completion?(true)
    }
    
    // Удаляет счет по его ID
    //TODO: сломалось удаление
    func deleteAccount(for id: ObjectId, completion: ((Bool) -> Void)? = nil) {
        guard let account = getAccount(for: id) else {
            completion?(false)
            return
        }
        
        RealmService.shared.delete(account, AccountClass.self)
        
        completion?(true)
    }
    
    // Отредактировать баланс счета
    func editBalance(for id: ObjectId, replacingBalance: Double, completion: ((Bool) -> Void)? = nil) {
        guard var account = getAccount(for: id) else {
            completion?(false)
            return
        }
        
        account = AccountClass(value: account)
        account.amountBalance = replacingBalance
        
        RealmService.shared.update(account, AccountClass.self)
        
        completion?(true)
    }
    
    func getAccountNames(from accounts: [AccountClass]) -> [String] {
        return accounts.map { $0.name }
    }
    
}
