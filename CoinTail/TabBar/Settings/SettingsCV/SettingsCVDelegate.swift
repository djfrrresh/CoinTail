//
//  SettingsCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


extension SettingsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc: UIViewController?
        
        switch indexPath.row {
        case 0:
            vc = CurrenciesVC()
        case 1:
            vc = NotificationsVC()
        case 2:
            vc = UIViewController()
        case 3:
            vc = UIViewController()
        case 4:
            vc = UIViewController()
        default:
            fatalError("no VC")
        }
        
        if let vc = vc {
            vc.hidesBottomBarWhenPushed = true
            
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
}
