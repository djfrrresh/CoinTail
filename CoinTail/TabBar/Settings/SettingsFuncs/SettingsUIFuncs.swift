//
//  SettingsUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 30.08.23.
//

import UIKit
import EasyPeasy


extension SettingsVC {
    
    func settingsSubviews() {
        self.view.addSubview(settingsCV)
        
        settingsCV.easy.layout([
            Left(),
            Right(),
            Bottom(),
            Top(32).to(view.safeAreaLayoutGuide, .top)
        ])
    }
    
}
