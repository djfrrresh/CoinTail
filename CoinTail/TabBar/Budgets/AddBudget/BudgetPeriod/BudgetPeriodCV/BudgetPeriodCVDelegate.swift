//
//  BudgetPeriodCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit


extension BudgetPeriodVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPeriod = periodsMenu[indexPath.row]
        
        periodsCV.reloadData()
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return RegularityCell.size()
    }
    
}
