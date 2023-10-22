//
//  RegularityCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import UIKit


extension RegularityVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let regularity = regularityMenu[indexPath.row]
        
        guard let notificationPeriod = NotificationPeriods(rawValue: regularity) else { return }
        
        Notifications.shared.regularity = notificationPeriod
        
        regularityCV.reloadData()
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return RegularityCell.size()
    }
    
}
