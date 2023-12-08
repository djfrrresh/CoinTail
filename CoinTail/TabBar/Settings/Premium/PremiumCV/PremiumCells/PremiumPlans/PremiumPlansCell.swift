//
//  PremiumPlansCell.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

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
