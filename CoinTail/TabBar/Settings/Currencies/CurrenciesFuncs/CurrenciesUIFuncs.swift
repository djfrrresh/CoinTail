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
            Height(36),
            CenterX(),
            Top(24).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        currenciesCV.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top(24).to(currencySearchBar, .bottom),
            Bottom()
        ])
    }
    
    // Скрытие currencySearchBar при прокрутке коллекции
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        let swipingDown = y <= 0
        
        UIView.animate(withDuration: 0.3) { [self] in
            currencySearchBar.alpha = swipingDown ? 1.0 : 0.0
            
            if currencySearchBar.alpha == 0.0 {
                currenciesCV.easy.layout([Top(16).to(view.safeAreaLayoutGuide, .top)])
            } else {
                currenciesCV.easy.layout([Top(24).to(currencySearchBar, .bottom)])
            }
            
            view.layoutIfNeeded()
        }
    }
    
}
