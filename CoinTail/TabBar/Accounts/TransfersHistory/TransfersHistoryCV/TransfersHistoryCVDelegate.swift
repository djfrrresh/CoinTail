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
        return TransfersHistoryCell.size()
    }
    
}
