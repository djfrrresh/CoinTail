//
//  WebViewVCFuncs.swift
//  CoinTail
//
//  Created by Eugene on 20.12.23.
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


extension WebViewVC {
    
    func webViewSubviews() {
        let isButton = buttonTitle != nil

        var bottomForWebView = Bottom()

        if isButton {
            button.setTitle(buttonTitle, for: .normal)

            view.addSubview(button)
                        
            button.easy.layout([
                Left(16),
                Height(50),
                Bottom(UIDevice.current.hasNotch ? 50 : 16),
                Right(16)
            ])
            
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            bottomForWebView = Bottom(32).to(button, .top)
        }
     
        view.addSubview(webView)
        
        webView.easy.layout([
            Top(),
            bottomForWebView,
            Left(),
            Right()
        ])
        
        webView.scrollView.contentInset = .init(top: 32, left: 0, bottom: 0, right: 0)
    }
    
    @objc private func buttonPressed() {
        dismiss(animated: true)
    }
    
}
