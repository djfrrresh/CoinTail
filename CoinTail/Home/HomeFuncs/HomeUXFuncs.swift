//
//  HomeUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 18.05.23.
//

import UIKit


extension HomeVC {
        
    func homeButtonTargets() {
        typeSwitcher.addTarget(self, action: #selector(switchAction), for: .valueChanged)
    }
        
}
