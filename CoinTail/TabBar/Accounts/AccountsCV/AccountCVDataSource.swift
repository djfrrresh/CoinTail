//
//  AccountCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AccountsVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AccountCell.id,
            for: indexPath
        ) as? AccountCell else {
            return UICollectionViewCell()
        }
        
        let accountData: Account = accounts[indexPath.row]
        var totalAmountForCash: Double = accountData.startBalance

        if let cashAccount = Accounts.shared.getAccount(for: accountData.id) {
            totalAmountForCash += Records.shared.calculateTotalBalance(for: cashAccount.id)
            
            // Обновить баланс для счета
            Accounts.shared.editBalance(for: cashAccount.id, replacingBalance: totalAmountForCash)
        }
        
        cell.amountLabel.text = "\(totalAmountForCash)"
        cell.nameLabel.text = accountData.name
        cell.currencyLabel.text = "\(accountData.currency)"
        
        return cell
    }
    
}
