//
//  CategoryCell.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
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


final class CategoryCVCell: UICollectionViewCell {
    
    static let id = "CategoryCVCell"
    
    let xmarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let categoryName: UILabel = getCategoryLabel()
    
    var isXmark: Bool = false
    
    static func getCategoryLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 1
        
        return label
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(categoryName)
        contentView.addSubview(xmarkImage)
        
        contentView.easy.layout([
            Edges()
        ])
        
        if isXmark {
            categoryName.easy.layout([
                Left(16),
                CenterY()
            ])
            xmarkImage.easy.layout([
                Left(8).to(categoryName),
                Height(20),
                Width(20),
                CenterY()
            ])
            
            xmarkImage.isHidden = false
        } else {
            categoryName.easy.layout([
                Center()
            ])
            
            xmarkImage.easy.clear()
            
            xmarkImage.isHidden = true
        }
    }
    
    static func size(data: String?, isXmark: Bool = false) -> CGSize {
        let category = getCategoryLabel()
        category.text = data ?? ""
        
        var xmarkWidth: CGFloat = 0
        
        if isXmark {
            xmarkWidth += 16 + 8
        }
                
        let textWidth = category.sizeThatFits(.init(width: 0, height: 0)).width
        let cellWidth = textWidth + 16 * 2 + xmarkWidth
        
        // Динамический размер одной ячейки с отступами по 16 с краёв
        return .init(width: cellWidth, height: 32)
    }

}
