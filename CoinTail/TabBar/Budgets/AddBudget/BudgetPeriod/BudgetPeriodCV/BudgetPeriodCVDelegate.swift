//
//  BudgetPeriodCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit


protocol SendRegularity: AnyObject {
    func sendPeriod(_ period: String)
}

extension BudgetPeriodVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard var selectedPeriod = self.selectedPeriod else { return }
        selectedPeriod = periodsMenu[indexPath.row]
        
        regulatiryDelegate?.sendPeriod(selectedPeriod)
        
        periodsCV.reloadData()
        
        navigationController?.popViewController(animated: true)
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return RegularityCell.size()
    }
    
}
