//
//  Transfers.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import Foundation


final class Transfers {
    
    static let shared = Transfers()
    
    // Добавить новый перевод
    func addNewTransfer(_ transfer: TransferHistoryClass) {
        RealmService.shared.write(transfer, TransferHistoryClass.self)
    }
    
    // Перевод средств между счетами
    func transferBetweenAccounts(from sourceAccountName: String, to targetAccountName: String, amount: Double) {
        var firstAccount: AccountClass
        var secondAccount: AccountClass

        guard let sourceAccount = Accounts.shared.getAccount(for: sourceAccountName),
              let targetAccount = Accounts.shared.getAccount(for: targetAccountName) else { return }
        
        firstAccount = AccountClass(value: sourceAccount)
        secondAccount = AccountClass(value: targetAccount)
                
        // Снимаем деньги с исходного счета и добавляем их на целевой счет
        firstAccount.startBalance -= amount
        secondAccount.startBalance += amount
        
        print(firstAccount)
        print(secondAccount)
        
        Accounts.shared.editAccount(for: sourceAccount.id, replacingAccount: firstAccount)
        Accounts.shared.editAccount(for: targetAccount.id, replacingAccount: secondAccount)
    }
    
}
