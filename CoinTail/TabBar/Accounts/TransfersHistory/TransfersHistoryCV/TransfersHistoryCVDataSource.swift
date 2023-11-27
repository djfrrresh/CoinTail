//
//  TransfersHistoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension TransfersHistoryVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return transfersDaySections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dayItems = transfersDaySections[section].transfers
        
        return dayItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TransfersHistoryCell.id,
            for: indexPath
        ) as? TransfersHistoryCell else {
            return UICollectionViewCell()
        }
        
        let section = transfersDaySections[indexPath.section]
        let transferData: TransferHistoryClass = section.transfers[indexPath.row]

        cell.sourceAmountLabel.text = "- \(transferData.amount) \(transferData.sourceCurrency)"
        cell.targetAmountLabel.text = "+ \(transferData.amount) \(transferData.targetCurrency)"
        cell.sourceAccountLabel.text = transferData.sourceAccount
        cell.targetAccountLabel.text = transferData.targetAccount
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TransfersHistoryCVHeader.id,
            for: indexPath
        ) as? TransfersHistoryCVHeader else {
            return UICollectionViewCell()
        }
        
        let section = transfersDaySections[indexPath.section]
        let transferData: TransferHistoryClass = section.transfers[indexPath.row]
        
        headerView.dateLabel.text = headerView.headerDF.string(from: transferData.date)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
}
