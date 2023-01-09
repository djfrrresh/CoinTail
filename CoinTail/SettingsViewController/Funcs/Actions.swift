//
//  SettingsActions.swift
//  CoinTail
//
//  Created by Eugene on 27.12.22.
//

import UIKit
import EasyPeasy


extension SettingsViewController {
    
    @objc func buttonAction(sender: UIButton!) {
        let vc = CurrencyTableVC()
        vc.currencyDelegate = self
        
        vc.title = "Select currency"
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
