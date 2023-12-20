//
//  HavePremiumActions.swift
//  CoinTail
//
//  Created by Eugene on 19.12.23.
//

import UIKit


extension HavePremiumVC {
    
    @objc func greatButtonAction() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        dismiss(animated: true)

        var presentingViewController = presentingViewController
        while presentingViewController != nil {
            presentingViewController?.dismiss(animated: true, completion: nil)
            presentingViewController = presentingViewController?.presentingViewController
        }
    }
    
}
