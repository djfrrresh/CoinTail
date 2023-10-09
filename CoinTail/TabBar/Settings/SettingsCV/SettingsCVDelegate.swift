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
            rateApp()
        case 3:
            vc = AboutAppVC()
        case 4:
            return
        default:
            return
        }
        
        if let vc = vc {
            if vc == AboutAppVC() {
                vc.modalPresentationStyle = .overCurrentContext

                self.present(vc, animated: true, completion: nil)
            } else {
                vc.hidesBottomBarWhenPushed = true
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
