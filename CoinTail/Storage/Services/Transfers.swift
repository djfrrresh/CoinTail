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
        // Снимаем деньги с исходного счета и добавляем их на целевой счет
        let firstAccountBalance = sourceAccount.startBalance - amount
        var secondAccountBalance: Double = targetAccount.startBalance
                
        if sourceAccount.currency != targetAccount.currency {
            let baseCurrency = Currencies.shared.selectedCurrency.currency

            guard let exchangeRatesToBase = ExchangeRateManager.shared.exchangeRates[baseCurrency],
                let exchangeRateFromBase = exchangeRatesToBase[targetAccount.currency],
                let exchangeRateToBase = exchangeRatesToBase[sourceAccount.currency] else {
                return
            }
            
            let convertedToBase = amount / exchangeRateToBase
            let convertedToAccountCurrency = convertedToBase * exchangeRateFromBase
            secondAccountBalance += convertedToAccountCurrency
            
            editAccounts(
                sourceAccount: sourceAccount,
                targetAccount: targetAccount,
                firstAccountBalance: firstAccountBalance,
                secondAccountBalance: secondAccountBalance
            )
            
            addTransferHistory(
                sourceAccount: sourceAccount,
                targetAccount: targetAccount,
                firstAccountBalance: firstAccountBalance,
                secondAccountBalance: secondAccountBalance,
                sourceAccountAmount: amount,
                targetAccountAmount: convertedToAccountCurrency
            )
        } else {
            secondAccountBalance += amount
            
            editAccounts(
                sourceAccount: sourceAccount,
                targetAccount: targetAccount,
                firstAccountBalance: firstAccountBalance,
                secondAccountBalance: secondAccountBalance
            )
            
            addTransferHistory(
                sourceAccount: sourceAccount,
                targetAccount: targetAccount,
                firstAccountBalance: firstAccountBalance,
                secondAccountBalance: secondAccountBalance,
                sourceAccountAmount: amount,
                targetAccountAmount: amount
            )
        }
    }
    
    // Функция для редактирования счетов
    func editAccounts(sourceAccount: AccountClass, targetAccount: AccountClass, firstAccountBalance: Double, secondAccountBalance: Double) {
        let firstAccount = AccountClass()
        let secondAccount = AccountClass()
        
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
    
    //TODO: оптимизировать повторения c editAccounts
    private func addTransferHistory(sourceAccount: AccountClass, targetAccount: AccountClass, firstAccountBalance: Double, secondAccountBalance: Double, sourceAccountAmount: Double, targetAccountAmount: Double) {
        let firstAccount = AccountClass()
        let secondAccount = AccountClass()
        
        firstAccount.id = sourceAccount.id
        firstAccount.currency = sourceAccount.currency
        firstAccount.name = sourceAccount.name
        firstAccount.startBalance = firstAccountBalance
        
        secondAccount.id = targetAccount.id
        secondAccount.currency = targetAccount.currency
        secondAccount.name = targetAccount.name
        secondAccount.startBalance = secondAccountBalance
        
        let transferHistory = TransferHistoryClass()
        transferHistory.sourceAccount = sourceAccount.name
        transferHistory.targetAccount = targetAccount.name
        transferHistory.sourceCurrency = sourceAccount.currency
        transferHistory.targetCurrency = targetAccount.currency
        transferHistory.sourceAmount = sourceAccountAmount
        transferHistory.targetAmount = targetAccountAmount
        transferHistory.date = Date()
        
        // Добавляем в историю перевод между счетами
        Transfers.shared.addNewTransfer(transferHistory)
    }
    
}
