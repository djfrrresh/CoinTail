//
//  SettingsCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension SettingsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc: UIViewController?
        
        switch indexPath.row {
        case 0:
            vc = CurrenciesVC()
        case 1:
            vc = NotificationsVC()
        case 2:
            rateApp()
        case 3:
            vc = AboutAppVC()
        case 4:
            return
        default:
            return
        }
        
        if let vc = vc {
            vc.hidesBottomBarWhenPushed = true
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SettingsCell.size()
    }
    
}
