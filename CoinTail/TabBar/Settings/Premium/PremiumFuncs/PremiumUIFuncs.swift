//
//  PremiumUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
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


extension PremiumVC {
    
    func premiumSubviews() {
        self.view.addSubview(buttonBackgroundView)
        self.view.addSubview(premiumCV)
        self.view.addSubview(premiumNavBarView)
        
        buttonBackgroundView.addSubview(buyPremiumButton)
        
        premiumStackView.addArrangedSubview(premiumAppName)
        premiumStackView.addArrangedSubview(premiumLabel)
        
        premiumNavBarView.addSubview(premiumStackView)
        premiumNavBarView.addSubview(navBarButton)
        
        navBarButton.easy.layout([
            Left(16),
            CenterY()
        ])

        premiumStackView.easy.layout([
            Center()
        ])
        
        premiumNavBarView.easy.layout([
            Top().to(view.safeAreaLayoutGuide, .top),
            Left(),
            Right(),
            Height(44)
        ])
        
        premiumCV.easy.layout([
            Top().to(premiumNavBarView),
            Left(),
            Right(),
            Bottom().to(buttonBackgroundView)
        ])
        
        let bottomIndent: CGFloat = UIDevice.current.hasNotch ? 50 : 16
        let buttonBackgroundViewHeight: CGFloat = 54 + 16 + bottomIndent
        
        buttonBackgroundView.easy.layout([
            Bottom(),
            Left(),
            Right(),
            Height(buttonBackgroundViewHeight)
        ])
        
        buyPremiumButton.easy.layout([
            Top(16),
            Left(16),
            Right(16),
            Height(54)
        ])
    }
    
}
