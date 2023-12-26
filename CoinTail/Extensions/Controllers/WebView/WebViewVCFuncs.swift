//
//  WebViewVCFuncs.swift
//  CoinTail
//
//  Created by Eugene on 20.12.23.
//

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
