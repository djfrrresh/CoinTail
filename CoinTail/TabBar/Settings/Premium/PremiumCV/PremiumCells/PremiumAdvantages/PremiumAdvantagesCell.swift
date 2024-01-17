//
//  PremiumAdvantagesCell.swift
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


final class PremiumAdvantagesCell: UICollectionViewCell {
    
    static let id = "PremiumAdvantagesCell"

    var advantagesCellData: [AdvantagesData] = []
    
    lazy private var advantagesCV: UICollectionView = {
        let plansLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 24
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: plansLayout)
        cv.backgroundColor = .clear
        cv.register(AdvantagesCell.self, forCellWithReuseIdentifier: AdvantagesCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.isScrollEnabled = false
        
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "arrowColor")?.cgColor
        contentView.layer.cornerRadius = 16
        
        advantagesCV.dataSource = self
        
        advantagesCV.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(advantagesCV)

        advantagesCV.easy.layout([
            Edges()
        ])
    }
    
    static func size(data: [AdvantagesData]) -> CGSize {
        var collectionHeight: CGFloat = CGFloat(24 * (data.count - 1))
        
        for moc in data {
            collectionHeight += AdvantagesCell.size(data: moc).height
        }
        
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: collectionHeight + 16 * 2
        )
    }
    
}
