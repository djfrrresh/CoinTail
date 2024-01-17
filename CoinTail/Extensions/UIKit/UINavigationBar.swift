//
//  UINavigationBar.swift
//  CoinTail
//
//  Created by Eugene on 14.12.23.
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


class CustomNavigationBar: UINavigationBar {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5 // Минимальный коэффициент масштабирования

        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)

        return label
    }()
    
    let customButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.tintColor = UIColor(named: "primaryAction")
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(customButton)
        addSubview(subTitleLabel)
        
        titleLabel.easy.layout([
            Left(16),
            Right(72),
            Bottom()
        ])
        
        customButton.easy.layout([
            Height(32),
            Width(32),
            CenterY().to(titleLabel),
            Right(16)
        ])
        
        subTitleLabel.easy.layout([
            Left(16),
            Right(16),
            Bottom(12).to(titleLabel, .top)
        ])
    }
    
}
