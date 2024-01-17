//
//  PremiumAlert.swift
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


final class PremiumAlert: UIViewController, UIPopoverPresentationControllerDelegate {
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        
        return view
    }()
    
    let overlayView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black
        view.alpha = 0
        
        return view
    }()
    
    let buyPremiumButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.setTitle("Buy premium".localized(), for: .normal)
        
        return button
    }()
    let dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("✖️", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Premium function".localized()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.sizeToFit()
        
        return label
    }()
    static var descriptionText: String = ""
    let descriptionLabel = getDescriptionLabel(text: descriptionText)
    
    let crownEmojiLabel: UILabel = {
        let label = UILabel()
        label.text = "👑"
        label.font = UIFont(name: "SFProText-Regular", size: 200)
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }()
    
    public required init(description: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
        
        PremiumAlert.descriptionText = description
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        alertSubviews()
        alertActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.overlayView.alpha = 0.3
        }
    }
    
}
