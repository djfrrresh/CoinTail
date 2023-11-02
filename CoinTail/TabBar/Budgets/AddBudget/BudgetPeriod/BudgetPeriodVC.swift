//
//  BudgetPeriodVC.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit


final class BudgetPeriodVC: BasicVC {
    
    var selectedPeriod: String = "Month".localized()
    
    let periodsMenu = [
        "Week".localized(),
        "Month".localized()
    ]

    let periodsCV: UICollectionView = {
        let regularityLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: regularityLayout)
        cv.backgroundColor = .clear
        cv.register(RegularityCell.self, forCellWithReuseIdentifier: RegularityCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.delaysContentTouches = true
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Time period".localized()
        
        periodsCV.delegate = self

        periodsCV.dataSource = self
                
        periodsSubviews()
    }
    
}
