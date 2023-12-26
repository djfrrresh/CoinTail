//
//  AboutAppUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import WebKit


extension AboutAppVC {
    
    func userAgreementAction() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        let privacy = Privacy.privacy
        let webView = WKWebView()
        
        if let url = URL(string: privacy.aboutLink.url) {
            let request = URLRequest(url: url)
            webView.load(request)

            let vc = WebViewVC(buttonTitle: "Read".localized())
            vc.webView = webView

            self.present(vc, animated: true)
        }
    }
    
}
