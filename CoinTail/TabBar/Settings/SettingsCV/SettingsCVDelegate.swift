//
//  SettingsCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension SettingsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
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
                deleteData()
            default:
                return
            }
            
            if let vc = vc {
                vc.hidesBottomBarWhenPushed = true
                
                navigationController?.pushViewController(vc, animated: true)
            }
        case 1:
            let vc = PremiumVC(PremiumPlans.shared.plans)
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true)
        default:
            return
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellIdentifier(for: indexPath) {
        case SettingsCell.id:
            return SettingsCell.size()
        case SettingsPremiumCell.id:
            return SettingsPremiumCell.size()
        default:
            return CGSize()
        }
    }
    
}
