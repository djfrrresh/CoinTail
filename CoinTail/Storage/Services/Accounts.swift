//
//  Accounts.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
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
