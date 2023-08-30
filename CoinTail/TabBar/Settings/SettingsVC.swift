//
//  SettingsVC.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit


class SettingsVC: BasicVC {
    
    let settingsMenu = [
        "Currency",
        "Notifications",
        "Rate app",
        "About app",
        "Delete data"
    ]
    let settingsMenuImages = [
        "dollarsign",
        "bell",
        "star",
        "iphone.gen1",
        "xmark.icloud"
    ]
    
    let settingsCV: UICollectionView = {
        let settingsLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: settingsLayout)
        cv.backgroundColor = .clear
        cv.register(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.delaysContentTouches = true
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings".localized()
        
        settingsCV.delegate = self

        settingsCV.dataSource = self
        
        settingsSubviews()
    }
    
}
