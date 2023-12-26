//
//  WebViewVC.swift
//  CoinTail
//
//  Created by Eugene on 20.12.23.
//

import UIKit
import WebKit
import EasyPeasy


class WebViewVC: BasicVC {
    
    var webView = WKWebView()
    var buttonTitle: String?
    
    let button: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
    
    init(buttonTitle: String? = nil) {
        self.buttonTitle = buttonTitle
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webViewSubviews()
    }
    
}
