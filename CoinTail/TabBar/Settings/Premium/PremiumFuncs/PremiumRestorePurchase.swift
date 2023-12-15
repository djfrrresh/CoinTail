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
        
//        let webView = WKWebView()
        
//        if let url = URL(string: link) {
//            let request = URLRequest(url: url)
//            webView.load(request)
//
//            let vc = WebViewController(buttonTitle: "Read".localized())
//            vc.webView = webView
//
//            self.presentCustom(vc, animated: true)
//        }
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
//                    let vc = YouSubscribedVC(AdvantagesData.advantages, expirationDate: expirationDate)
//                    vc.modalPresentationStyle = .fullScreen
//
//                    present(vc, animated: true)
                }
            case .noSubs:
                print("noSubs")
                //TODO: error alert
//                let alert = UIAlertController(title: .localized("restore_purchase_no_subs_title"), message: nil, preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: .localized("okay_button_title"), style: .cancel)
//
//                alert.addAction(alertAction)
//                self?.present(alert, animated: true)
            case .noData:
                print("noData")
                //TODO: error alert
//                let alert = UIAlertController(title: .localized("restore_purchase_no_data_title"), message: nil, preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: .localized("okay_button_title"), style: .cancel)
//
//                alert.addAction(alertAction)
//                self?.present(alert, animated: true)
            }

            strongSelf.buyPremiumButton.waitingState(false)
            strongSelf.view.isUserInteractionEnabled = true
        }
    }
    
}
