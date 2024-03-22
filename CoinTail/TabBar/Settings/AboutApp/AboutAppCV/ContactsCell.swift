//
//  ContactsCell.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
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


final class ContactsCell: UICollectionViewCell {
    
    static let id = "ContactsCell"

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let contactsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = .black

        return label
    }()
    let menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    let submenuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor(named: "secondaryTextColor")
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    let userAgreementLabel: UILabel = {
        let label = UILabel()
        label.text = "User agreement".localized()
        label.textColor = .black
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()

    let contactsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        
        return imageView
    }()
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
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
        
        contentView.addSubview(contactsLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(separatorView)
        contentView.addSubview(contactsImageView)
        contentView.addSubview(userAgreementLabel)
        contentView.addSubview(submenuLabel)
        contentView.addSubview(menuLabel)
        
        contentView.easy.layout([
            Edges()
        ])
        
        separatorView.easy.layout([
            Bottom(),
            Right(),
            Left().to(contactsLabel, .left),
            Height(0.5)
        ])
        
        chevronImageView.easy.layout([
            Right(16),
            CenterY(),
            Height(20),
            Width(20)
        ])
        
        contactsImageView.easy.layout([
            Left(16),
            CenterY()
        ])

        contactsLabel.easy.layout([
            Left(12).to(contactsImageView, .right),
            CenterY()
        ])
        
        menuLabel.easy.layout([
            Left(16),
            Right(16),
            Top(12)
        ])
        
        submenuLabel.easy.layout([
            Left(16),
            Right(16),
            Bottom(12)
        ])
        
        userAgreementLabel.easy.layout([
            Left(16),
            Right(4).to(chevronImageView, .left),
            CenterY()
        ])
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 44
        )
    }
    static func appVersionSize() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 72
        )
    }
    
}
