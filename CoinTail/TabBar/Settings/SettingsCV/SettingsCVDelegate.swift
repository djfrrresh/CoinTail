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
            vc = CurrenciesVC()
        case 2:
            vc = CurrenciesVC()
        case 3:
            vc = CurrenciesVC()
        case 4:
            vc = CurrenciesVC()
        default:
            fatalError("no VC")
        }
        
        if let vc = vc {
            vc.hidesBottomBarWhenPushed = true
            
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
}
