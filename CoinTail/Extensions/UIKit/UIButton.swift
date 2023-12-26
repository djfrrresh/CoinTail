//
//  UIButton.swift
//  CoinTail
//
//  Created by Eugene on 08.12.23.
//

import UIKit
import EasyPeasy

extension UIButton {
    
    func waitingState(_ isWaiting: Bool) {
        self.loadingIndicator(isWaiting)
        self.isEnabled = !isWaiting
        
        if isWaiting == true {
            self.setTitleColor(.clear, for: .disabled)
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
        } else {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            self.setTitleColor(currentTitleColor, for: .disabled)
        }
    }
    
}
