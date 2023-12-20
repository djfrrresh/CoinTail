//
//  PremiumActions.swift
//  CoinTail
//
//  Created by Eugene on 08.12.23.
//

import UIKit


extension PremiumVC {
    
    @objc func backButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func buyButtonAction() {
        buyPremiumButton.waitingState(true)
        self.view.isUserInteractionEnabled = false
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        revenueCatPayment()
    }
    
}
