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
        self.view.addSubview(currencySearchBar)
        self.view.addSubview(currenciesCV)
        
        currencySearchBar.easy.layout([
            Left(16),
            Right(16),
            Height(48),
            CenterX(),
            Top().to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        currenciesCV.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top(8).to(currencySearchBar, .bottom),
            Bottom()
        ])
    }
    
}
