//
//  CustomNotificationView.swift
//  CoinTail
//
//  Created by Eugene on 21.03.24.
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


class CustomNotificationView: UIView {
    
    lazy var button = UIButton()
    var height: CGFloat = 60
    var width: CGFloat = UIScreen.main.bounds.width - 16 * 2
    
    lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "snackbarBackground")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        
        return view
    }()
    
    lazy var blurBackground = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    init() {
        super.init(frame: .zero)
        
        addSubview(background)
        background.addSubview(blurBackground)
        background.addSubview(button)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        bounds = CGRect(
            origin: .zero,
            size: CGSize(width: size.width, height: 0)
        )
        layoutSubviews()
        
        return CGSize(width: size.width, height: background.frame.maxY)
    }
    
    override func layoutSubviews() {
        background.easy.layout([
            CenterX(),
            Width(width),
            Height(height),
            Top()
        ])
        
        background.frame = CGRect(x: 16, y: background.frame.origin.y, width: width, height: height)
        blurBackground.frame = background.bounds
        button.frame = background.bounds
    }
    
}
