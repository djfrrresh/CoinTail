//
//  PremiumRestorePurchase.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

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
        
        PaymentFacade.shared.restorePurchases { [weak self] resp in
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
