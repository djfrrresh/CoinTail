//
//  PremiumRestorePurchase.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
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

import WebKit


extension PremiumVC: PremiumPrivacyDelegate {

    func showLegalDocuments(link: String) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        let webView = WKWebView()
        
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.load(request)

            let vc = WebViewVC(buttonTitle: "Read".localized())
            vc.webView = webView

            self.present(vc, animated: true)
        }
    }
    
    func restorePurchaseButtonTap() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        buyPremiumButton.waitingState(true)
        self.view.isUserInteractionEnabled = false
        
        RevenueCatService.shared.restorePurchases { [weak self] resp in
            guard let strongSelf = self else { return }

            switch resp {
            case .success(let expirationDate):
                strongSelf.dismiss(animated: false) {
                    let vc = HavePremiumVC(AdvantagesData.advantages, expirationDate: expirationDate)
                    vc.modalPresentationStyle = .fullScreen
                    
                    strongSelf.present(vc, animated: true)
                }
            case .noSubs:
                strongSelf.infoAlert("No valid premium subscription found on this account".localized())
            case .noData:
                strongSelf.infoAlert("Failed to restore subscription".localized())
            }

            strongSelf.buyPremiumButton.waitingState(false)
            strongSelf.view.isUserInteractionEnabled = true
        }
    }
    
}
