//
//  CurrencyCell.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
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


final class CurrencyCell: UICollectionViewCell {
    
    static let id = "CurrencyCell"
        
    var currency: String?
    
    var currenciesCV: UICollectionView?
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    
    let currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    
    let favouriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "primaryAction")
        
        return button
    }()
    
    let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(named: "primaryAction")
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "checkmark")
        imageView.isHidden = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        
        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(checkmarkImageView)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(currencyCodeLabel)
        contentView.addSubview(currencyNameLabel)
        contentView.addSubview(separatorView)
        
        contentView.easy.layout([
            Edges()
        ])
        
        favouriteButton.easy.layout([
            Height(20),
            Width(20),
            Left(16),
            CenterY()
        ])
        
        let currencyCodeWidth = currencyCodeLabel.sizeThatFits(.zero).width
        currencyCodeLabel.easy.layout([
            Left(8).to(favouriteButton, .right),
            Width(currencyCodeWidth),
            CenterY()
        ])
        
        currencyNameLabel.easy.layout([
            Right(8).to(checkmarkImageView, .left),
            Left(8).to(currencyCodeLabel, .right),
            CenterY()
        ])
        
        separatorView.easy.layout([
            Bottom(),
            Right(),
            Left().to(currencyCodeLabel, .left),
            Height(0.5)
        ])
        
        checkmarkImageView.easy.layout([
            Height(20),
            Width(20),
            Right(16),
            CenterY()
        ])
    }
    
    func isFavourite(currency: String, array: [String]) {
        if Currencies.shared.hasCurrency(currency, array: array) {
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    @objc func favouriteButtonPressed(_ sender: UIButton) {
        guard let currency = currency else { return }
        
        let favouriteCurrency = Currencies.shared.getCurrencyClass(for: currency)

        Currencies.shared.toggleFavouriteCurrency(favouriteCurrency)
        
        currenciesCV?.reloadData()
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 44
        )
    }
    
}
