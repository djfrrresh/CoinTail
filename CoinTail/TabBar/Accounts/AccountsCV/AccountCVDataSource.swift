//
//  AccountCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AccountsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            fatalError("Unable to dequeue AccountCell.")
        }
        
        let accountData: Account = accounts[indexPath.row]
        
        cell.amountLabel.text = "\(accountData.amount)"
        cell.nameLabel.text = accountData.name
        
        return cell
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AccountCell.size()
    }
    
}
