//
//  NotificationsCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 19.10.23.
//

import UIKit


extension NotificationsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vc = RegularityVC()
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return NotificationsCell.size()
    }
    
}
