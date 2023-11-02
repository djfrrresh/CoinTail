//
//  TransfersHistoryCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension TransfersHistoryVC: UICollectionViewDelegateFlowLayout {
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let transferHistoryData: TransferHistoryClass?
        let section = transfersDaySections[indexPath.section]
        
        transferHistoryData = section.transfers[indexPath.row]
        
        guard let transfer = transferHistoryData else { return .init(width: 0, height: 0) }
        
        return TransfersHistoryCell.size(data: transfer)
    }
    
}
