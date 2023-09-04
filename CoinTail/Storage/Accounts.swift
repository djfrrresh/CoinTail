//
//  Accounts.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


final class Accounts {
    
    static let shared = Accounts()

    // Массив всех счетов
    var accounts = [Account]()
    
    // TODO: исправить на 0, если отсутствует Mock!
    var accountID = 3
    
    // Добавить счет
    func addNewAccount(_ account: Account) {
        accounts.append(account)
    }
    
    // Получить счет по его ID
    func getAccount(for id: Int) -> Account? {
        return accounts.filter { $0.id == id }.first
    }
    
    // Сверить счет по названию
    func getAccount(for name: String) -> Account? {
        return accounts.filter { $0.name == name }.last
    }
    
    // Отредактировать счет по его ID
    func editAccount(for id: Int, replacingAccount: Account, completion: ((Bool) -> Void)? = nil) {
        guard let account = getAccount(for: id),
              let index = accounts.firstIndex(of: account) else {
            completion?(false)
            return
        }
        
        accounts[index] = replacingAccount
        completion?(true)
    }
    
    // Удаляет счет по его ID
    func deleteAccount(for id: Int, completion: ((Bool) -> Void)? = nil) {
        guard let account = getAccount(for: id),
              let index = accounts.firstIndex(of: account) else {
            completion?(false)
            return
        }
        
        accounts.remove(at: index)
        completion?(true)
    }
    
}
