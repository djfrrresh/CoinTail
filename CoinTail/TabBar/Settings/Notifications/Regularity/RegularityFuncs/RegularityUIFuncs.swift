//
//  RegularityUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import UIKit
import EasyPeasy


extension RegularityVC {
    
    func regularitySubviews() {
        self.view.addSubview(regularityCV)
        
        regularityCV.easy.layout([
            Left(16),
            Right(16),
            CenterY(),
            Top(24).to(self.view.safeAreaLayoutGuide, .top),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom)
        ])
    }
    
}
