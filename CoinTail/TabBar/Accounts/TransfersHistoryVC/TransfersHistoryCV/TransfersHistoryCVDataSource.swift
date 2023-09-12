//
//  TransfersHistoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension TransfersHistoryVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transfers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TransfersHistoryCell.id,
            for: indexPath
        ) as? TransfersHistoryCell else {
            fatalError("Unable to dequeue TransfersHistoryCell.")
        }
        
        let transferData: TransferHistory = transfers[indexPath.row]

        cell.amountLabel.text = "\(transferData.amount)"
        cell.sourceAccountLabel.text = transferData.sourceAccount
        cell.targetAccountLabel.text = transferData.targetAccount
        
        return cell
    }
    
}
