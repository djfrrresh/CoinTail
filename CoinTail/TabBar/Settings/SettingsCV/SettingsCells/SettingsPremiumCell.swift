//
//  SettingsPremiumCell.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
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


final class SettingsPremiumCell: UICollectionViewCell {
    
    static let id = "SettingsPremiumCell"
            
    var premiumLabel: UILabel = SettingsPremiumCell.getPremiumLabel()
    var premiumDescription: UILabel = SettingsPremiumCell.getPremiumDescriptionLabel()
    
    let boltImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bolt.fill")
        imageView.tintColor = UIColor(named: "primaryAction")
        
        return imageView
    }()
    let crownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "crown.fill")
        imageView.tintColor = .white
        imageView.isHidden = true
        
        return imageView
    }()
    
    let imageBackView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                        
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = UIColor(named: "primaryAction")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(imageBackView)
        contentView.addSubview(premiumLabel)
        contentView.addSubview(premiumDescription)
                
        contentView.easy.layout([
            Edges()
        ])
        
        imageBackView.easy.layout([
            Height(48),
            Width(48),
            CenterY(),
            Left(16)
        ])
        
        imageBackView.addSubview(boltImageView)
        imageBackView.addSubview(crownImageView)

        boltImageView.easy.layout([
            Height(24),
            Width(24),
            Center()
        ])
        
        crownImageView.easy.layout([
            Height(36),
            Width(36),
            Center()
        ])

        premiumLabel.easy.layout([
            Left(16).to(imageBackView, .right),
            Right(16),
            Top(16)
        ])
        
        premiumDescription.easy.layout([
            Left(16).to(imageBackView, .right),
            Right(16),
            Bottom(16),
            Top(8).to(premiumLabel, .bottom)
        ])
    }
    
    func isPremiumActive(_ isActive: Bool) {
        if isActive {
            crownImageView.isHidden = false
            boltImageView.isHidden = true
            imageBackView.backgroundColor = .white.withAlphaComponent(0.3)
            imageBackView.layer.cornerRadius = 24
            premiumLabel.text = "Premium is active".localized()
            premiumDescription.text = "All the features of a premium subscription are available".localized()
        } else {
            boltImageView.isHidden = false
            crownImageView.isHidden = true
            imageBackView.backgroundColor = .white
            imageBackView.layer.cornerRadius = 12
            premiumLabel.text = "Upgrade to premium".localized()
            premiumDescription.text = "Get even more features with our Premium subscription".localized()
        }
    }
    
    static func getPremiumLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return label
    }
    
    static func getPremiumDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .white.withAlphaComponent(0.8)
        
        return label
    }
    
    static func size(_ isPremium: Bool) -> CGSize {
        let imagePadding: CGFloat = 16
        let imageWidth: CGFloat = 48
        let defaultHeight: CGFloat = 76
        let premiumLabel = getPremiumLabel()
        let premiumDescriptionLabel = getPremiumDescriptionLabel()
        
        if isPremium {
            premiumLabel.text = "Upgrade to premium".localized()
            premiumDescriptionLabel.text = "Get even more features with our Premium subscription".localized()
        } else {
            premiumLabel.text = "Premium is active".localized()
            premiumDescriptionLabel.text = "All the features of a premium subscription are available".localized()
        }
        
        let textWidth = UIScreen.main.bounds.width - (2 * 16) - (2 * 16) - imagePadding - imageWidth
        let premiumLabelHeight: CGFloat = premiumLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let premiumDescriptionHeight: CGFloat = premiumDescriptionLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        
        let labelsHeight = premiumLabelHeight + premiumDescriptionHeight + (2 * 16) + 8
        let cellHeight = labelsHeight > defaultHeight ? labelsHeight : defaultHeight
        
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: cellHeight
        )
    }
    
}
