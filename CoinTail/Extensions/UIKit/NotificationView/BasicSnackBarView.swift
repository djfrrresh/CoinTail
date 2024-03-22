//
//  BasicSnackBarView.swift
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


final class BasicSnackBarView: CustomNotificationView {
    
    private lazy var iconView: UIImageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    init(title: String, image: UIImage) {
        super.init()
        titleLabel.text = title
        titleLabel.sizeToFit()
        iconView.image?.withTintColor(.white)
        iconView.image = image
        
        background.addSubview(iconView)
        background.addSubview(titleLabel)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        height = 60
        background.layer.cornerRadius = 16
        background.backgroundColor = UIColor(named: "snackbarBackground")
        
        iconView.easy.layout([
            Left(16),
            CenterY(),
            Width(24),
            Height(24)
        ])
        titleLabel.easy.layout([
            Left(12).to(iconView),
            CenterY(),
            Right(8)
        ])
        
        super.layoutSubviews()
    }
    
    func show() {
        SnackBarController().show(self)
    }
    
}
