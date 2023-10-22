//
//  RegularityVC.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import UIKit


final class RegularityVC: BasicVC {
    
    var selectedRegularity: NotificationPeriods { Notifications.shared.regularity }
    
    let regularityMenu = [
        NotificationPeriods.daily.rawValue,
        NotificationPeriods.weekly.rawValue
    ]

    let regularityCV: UICollectionView = {
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
        
        self.title = "Regularity".localized()
        
        regularityCV.delegate = self

        regularityCV.dataSource = self
                
        regularitySubviews()
    }
    
}
