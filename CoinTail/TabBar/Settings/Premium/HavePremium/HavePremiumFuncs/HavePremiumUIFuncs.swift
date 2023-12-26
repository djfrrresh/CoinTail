//
//  HavePremiumUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 19.12.23.
//

import UIKit
import EasyPeasy


extension HavePremiumVC {
    
    func havePremiumSubviews() {
        self.view.addSubview(bottomView)
        self.view.addSubview(havePremiumCV)
        
        bottomView.addSubview(greatButton)
        
        havePremiumCV.easy.layout(
            Top().to(view.safeAreaLayoutGuide, .top),
            Left(),
            Right(),
            Bottom().to(bottomView)
        )
        
        let bottomIndent: CGFloat = UIDevice.current.hasNotch ? 50 : 16
        let bottomViewHeight: CGFloat = 54 + 16 + bottomIndent
        
        bottomView.easy.layout(
            Bottom(),
            Left(),
            Right(),
            Height(bottomViewHeight)
        )
        
        greatButton.easy.layout(
            Top(16),
            Left(16),
            Height(54),
            Right(16)
        )
    }
    
}
