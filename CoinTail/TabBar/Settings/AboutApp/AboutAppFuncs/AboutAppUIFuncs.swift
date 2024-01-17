//
//  AboutAppUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 06.10.23.
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


extension AboutAppVC {
    
    func aboutSubviews() {
        self.view.addSubview(aboutImageView)
        self.view.addSubview(aboutTitleLabel)
        self.view.addSubview(accountsDescriptionLabel)
        self.view.addSubview(contactsCV)

        aboutImageView.easy.layout([
            Height(150),
            Width(150),
            Top(16).to(self.view.safeAreaLayoutGuide, .top),
            CenterX()
        ])
        
        aboutTitleLabel.easy.layout([
            Top(16).to(aboutImageView, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        accountsDescriptionLabel.easy.layout([
            Top(16).to(aboutTitleLabel, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        contactsCV.easy.layout([
            Top(24).to(accountsDescriptionLabel, .bottom),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom),
            Left(16),
            Right(16),
            CenterX()
        ])
        
        chevronImageView.easy.layout([
            Right(16),
            CenterY(),
            Height(20),
            Width(20)
        ])
    }
    
}
