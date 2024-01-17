//
//  AdvantagesCell.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
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


final class AdvantagesCell: UICollectionViewCell {
    
    static let id = "AdvantagesCell"
    
    let advantageIcon: UILabel = getAdvantageIcon()

    let advantageLabel: UILabel = getAdvantageLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(advantageIcon)
        contentView.addSubview(advantageLabel)

        advantageIcon.easy.layout([
            CenterY(),
            Left(),
            Height(32),
            Width(32)
        ])
        
        advantageLabel.easy.layout([
            CenterY(),
            Left(16).to(advantageIcon),
            Right()
        ])
    }
    
    static func getAdvantageLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }
    
    static func getAdvantageIcon() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 32)
        label.backgroundColor = .clear
        
        return label
    }
    
    static func size(data: AdvantagesData) -> CGSize {
        let imageHeight: CGFloat = 26
        let textWidth =  UIScreen.main.bounds.width - 16 - 26 - 15
        
        let description = getAdvantageLabel()
        description.text = data.descriptionText
        let descriptionSize = description.sizeThatFits(.init(width: textWidth, height: 0))
        
        let textHeight = descriptionSize.height
        
        return .init(
            width: UIScreen.main.bounds.width - 32 - 32,
            height: imageHeight > textHeight ? imageHeight : textHeight
        )
    }
    
}
