//
//  NotificationsUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
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


extension NotificationsVC {
    
    func notificationsSubviews() {
        self.view.addSubview(bellEmojiLabel)
        self.view.addSubview(notificationsTitleLabel)
        self.view.addSubview(notificationsDescriptionLabel)
        self.view.addSubview(notificationsCV)

        bellEmojiLabel.easy.layout([
            Height(100),
            Width(100),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            CenterX()
        ])
        
        notificationsTitleLabel.easy.layout([
            Top(24).to(bellEmojiLabel, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        notificationsDescriptionLabel.easy.layout([
            Top(16).to(notificationsTitleLabel, .bottom),
            CenterX(),
            Left(32),
            Right(32)
        ])
        
        notificationsCV.easy.layout([
            Top(32).to(notificationsDescriptionLabel, .bottom),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom),
            CenterX(),
            Left(16),
            Right(16)
        ])
    }
    
}
