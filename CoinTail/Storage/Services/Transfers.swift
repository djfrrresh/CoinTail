//
//  Transfers.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import Foundation


final class Transfers {
    
    static let shared = Transfers()
    
    var transfers: [TransferHistoryClass] {
        get {
            return RealmService.shared.transfersHistoryArr
        }
    }
    
    // Добавить новый перевод
    func addNewTransfer(_ transfer: TransferHistoryClass) {
        RealmService.shared.write(transfer, TransferHistoryClass.self)
    }
    
    // Перевод средств между счетами
    func transferBetweenAccounts(from sourceAccount: AccountClass, to targetAccount: AccountClass, amount: Double) {
        let firstAccount = AccountClass()
        let secondAccount = AccountClass()
        
        // Снимаем деньги с исходного счета и добавляем их на целевой счет
        let firstAccountBalance = sourceAccount.startBalance - amount
        let secondAccountBalance = targetAccount.startBalance + amount
        
        firstAccount.id = sourceAccount.id
        firstAccount.currency = sourceAccount.currency
        firstAccount.name = sourceAccount.name
        firstAccount.startBalance = firstAccountBalance
        
        secondAccount.id = targetAccount.id
        secondAccount.currency = targetAccount.currency
        secondAccount.name = targetAccount.name
        secondAccount.startBalance = secondAccountBalance
        
        Accounts.shared.editAccount(replacingAccount: firstAccount)
        Accounts.shared.editAccount(replacingAccount: secondAccount)
    }
    
}
