//
//  SettingsUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 30.08.23.
//

import UIKit
import EasyPeasy
import StoreKit


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
    
    // Оценка приложения в AppStore
    func rateApp() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
}
