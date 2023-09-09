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
//    var accounts = [Account]()
    var accounts: [Account] = [
        Account(id: 0, name: "Cash", balance: 200),
        Account(id: 1, name: "Card 1", balance: 1000),
        Account(id: 2, name: "Card 2", balance: 50)
    ]
    
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
    
    // Получить счет по его имени
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
    
    // Отредактировать баланс счета
    func editBalance(for id: Int, replacingBalance: Double, completion: ((Bool) -> Void)? = nil) {
        guard let account = getAccount(for: id),
              let index = accounts.firstIndex(of: account) else {
            completion?(false)
            return
        }
        
        accounts[index].balance = replacingBalance
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
    
    // Перевод средств между счетами
    func transferBetweenAccounts(from sourceAccountName: String, to targetAccountName: String, amount: Double) {
        var firstAccount: Account
        var secondAccount: Account

        guard let sourceAccount = getAccount(for: sourceAccountName),
              let targetAccount = getAccount(for: targetAccountName) else { return }
        
        firstAccount = sourceAccount
        secondAccount = targetAccount
        
        // Снимаем деньги с исходного счета и добавляем их на целевой счет
        firstAccount.balance -= amount
        secondAccount.balance += amount
        
        editAccount(for: sourceAccount.id, replacingAccount: firstAccount)
        editAccount(for: targetAccount.id, replacingAccount: secondAccount)
    }
    
}
