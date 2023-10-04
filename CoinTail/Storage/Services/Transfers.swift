//
//  Transfers.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import Foundation


final class Transfers {
    
    static let shared = Transfers()
    
    // История переводов между счетами
    var transfersHistory: [TransferHistory] = [
        TransferHistory(
            sourceAccount: "Cash",
            targetAccount: "Card 1",
            amount: 300,
            date: Date()
        ),
        TransferHistory(
            sourceAccount: "Card 1",
            targetAccount: "Card 2",
            amount: 1000,
            date: Date()
        ),
        TransferHistory(
            sourceAccount: "Card 2",
            targetAccount: "Card 1",
            amount: 50,
            date: Date()
        )
    ]
    
    // Добавить новый перевод
    func addNewTransfer(_ transfer: TransferHistory) {
        transfersHistory.append(transfer)
    }
    
    // Перевод средств между счетами
    func transferBetweenAccounts(from sourceAccountName: String, to targetAccountName: String, amount: Double) {
        var firstAccount: Account
        var secondAccount: Account

        guard let sourceAccount = Accounts.shared.getAccount(for: sourceAccountName),
              let targetAccount = Accounts.shared.getAccount(for: targetAccountName) else { return }
        
        firstAccount = sourceAccount
        secondAccount = targetAccount
        
        // Снимаем деньги с исходного счета и добавляем их на целевой счет
        firstAccount.startBalance -= amount
        secondAccount.startBalance += amount
        
        Accounts.shared.editAccount(for: sourceAccount.id, replacingAccount: firstAccount)
        Accounts.shared.editAccount(for: targetAccount.id, replacingAccount: secondAccount)
    }
    
}
