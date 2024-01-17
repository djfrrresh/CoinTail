//
//  PremiumDescriptionCell.swift
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


final class PremiumDescriptionCell: UICollectionViewCell {
    
    static let id = "PremiumDescriptionCell"
    
    let descriptionLabel: UILabel = getDescriptionLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.backgroundColor = .clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(descriptionLabel)
        
        contentView.easy.layout([
            Edges()
        ])
        
        descriptionLabel.easy.layout([
            Left(),
            Right(),
            Bottom()
        ])
    }
    
    static func getDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }
    
    static func size(description: String) -> CGSize {
        let textWidth =  UIScreen.main.bounds.width - 16 * 2

        let descriptionLabel = getDescriptionLabel()
        descriptionLabel.text = description
        
        let descriptionSize = descriptionLabel.sizeThatFits(.init(width: textWidth, height: 0))
        
        let textHeight = descriptionSize.height + 16
        
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: textHeight
        )
    }
    
}
