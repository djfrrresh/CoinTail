//
//  PremiumPlansCell.swift
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


protocol PremiumPlansDelegate: AnyObject {
    func selectedPlanCell(_ index: Int, isSelectedBefore: Bool)
    var selectedPlan: PlanData { get }
}

final class PremiumPlansCell: UICollectionViewCell {
    
    static let id = "PremiumPlansCell"
    
    weak var plansDelegate: PremiumPlansDelegate?
    
    var planCellData: [PlanData] = [] {
        didSet {
            plansCV.reloadData()
        }
    }
    var planCellSize: CGSize!
    
    lazy var plansCV: UICollectionView = {
        let plansLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            layout.scrollDirection = .horizontal
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: plansLayout)
        cv.backgroundColor = .clear
        cv.register(PlanCell.self, forCellWithReuseIdentifier: PlanCell.id)
        cv.contentInset = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.isScrollEnabled = true
        cv.delaysContentTouches = true
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.backgroundColor = .clear
        
        plansCV.dataSource = self
        
        plansCV.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(plansCV)
        
        plansCV.easy.layout([
            Edges()
        ])
        
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width,
            height: 120
        )
    }
    
}
