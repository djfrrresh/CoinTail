//
//  SettingsCell.swift
//  CoinTail
//
//  Created by Eugene on 30.08.23.
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


final class SettingsCell: UICollectionViewCell {
    
    static let id = "SettingsCell"

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.textColor = .black

        return label
    }()
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.isHidden = true
        label.textColor = UIColor(named: "secondaryTextColor")

        return label
    }()
    
    let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        
        return imageView
    }()
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "arrowColor")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(menuImageView)
        contentView.addSubview(menuLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(separatorView)
        
        contentView.easy.layout([
            Edges()
        ])
        
        menuImageView.easy.layout([
            Left(16),
            CenterY(),
            Height(24),
            Width(24)
        ])

        menuLabel.easy.layout([
            Left(12).to(menuImageView, .right),
            CenterY()
        ])
        
        separatorView.easy.layout([
            Bottom(),
            Right(),
            Left().to(menuLabel, .left),
            Height(0.5)
        ])
        
        chevronImageView.easy.layout([
            Right(8),
            CenterY(),
            Height(20),
            Width(20)
        ])
        
        currencyLabel.easy.layout([
            CenterY(),
            Right(4).to(chevronImageView, .left)
        ])
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 52
        )
    }
    
}
