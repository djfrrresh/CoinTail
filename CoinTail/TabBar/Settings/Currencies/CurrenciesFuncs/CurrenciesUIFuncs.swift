//
//  CurrenciesUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 13.09.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import EasyPeasy


extension CurrenciesVC {
    
    func currenciesSubviews() {
        self.view.addSubview(currencySearchBar)
        self.view.addSubview(currenciesCV)
        
        currencySearchBar.easy.layout([
            Left(8),
            Right(8),
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
