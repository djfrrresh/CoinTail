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
        } else {
            secondAccountBalance += amount
        }

        editAccounts(
            sourceAccount: sourceAccount,
            targetAccount: targetAccount,
            firstAccountBalance: firstAccountBalance,
            secondAccountBalance: secondAccountBalance,
            sourceAccountAmount: amount,
            targetAccountAmount: secondAccountBalance - targetAccount.startBalance
        )
    }
        
    // Функция для редактирования счетов
    func editAccounts(sourceAccount: AccountClass, targetAccount: AccountClass, firstAccountBalance: Double, secondAccountBalance: Double, sourceAccountAmount: Double, targetAccountAmount: Double) {
        let updatedSourceAccount = createUpdatedAccount(from: sourceAccount, withBalance: firstAccountBalance)
        let updatedTargetAccount = createUpdatedAccount(from: targetAccount, withBalance: secondAccountBalance)

        Accounts.shared.editAccount(replacingAccount: updatedSourceAccount)
        Accounts.shared.editAccount(replacingAccount: updatedTargetAccount)

        addTransferHistory(
            sourceAccount: sourceAccount,
            targetAccount: targetAccount,
            sourceAccountAmount: sourceAccountAmount,
            targetAccountAmount: targetAccountAmount
        )
    }
    
    private func createUpdatedAccount(from account: AccountClass, withBalance balance: Double) -> AccountClass {
        let updatedAccount = AccountClass()
        updatedAccount.id = account.id
        updatedAccount.currency = account.currency
        updatedAccount.name = account.name
        updatedAccount.startBalance = balance
        
        return updatedAccount
    }
    
    // Добавляем в историю перевод между счетами
    private func addTransferHistory(sourceAccount: AccountClass, targetAccount: AccountClass, sourceAccountAmount: Double, targetAccountAmount: Double) {
        let transferHistory = TransferHistoryClass()
        transferHistory.sourceAccount = sourceAccount.name
        transferHistory.targetAccount = targetAccount.name
        transferHistory.sourceCurrency = sourceAccount.currency
        transferHistory.targetCurrency = targetAccount.currency
        transferHistory.sourceAmount = sourceAccountAmount
        transferHistory.targetAmount = targetAccountAmount
        transferHistory.date = Date()

        Transfers.shared.addNewTransfer(transferHistory)
    }
    
}
