//
//  CurrenciesUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 13.09.23.
//

import UIKit
import EasyPeasy


extension CurrenciesVC {
    
    func currenciesSubviews() {
        self.view.addSubview(currenciesCV)
        
        currenciesCV.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Bottom()
        ])
    }
    
}
