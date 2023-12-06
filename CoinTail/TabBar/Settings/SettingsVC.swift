//
//  SettingsVC.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit


final class SettingsVC: BasicVC {
    
    var selectedCurrency: String = Currencies.shared.selectedCurrency.currency {
        didSet {
            settingsCV.reloadData()
        }
    }
    
    let settingsMenu = [
        "Currency".localized(),
        "Notifications".localized(),
        "Rate on App Store".localized(),
        "About".localized(),
        "Delete data".localized()
    ]
    let settingsMenuImages = [
        "dollarsign.circle.fill",
        "bell.fill",
        "star.fill",
        "globe",
        "xmark.icloud.fill"
    ]
    let settingsMenuColors = [
        "currency",
        "notifications",
        "rateApp",
        "about",
        "deleteData"
    ]
    
    let settingsCV: UICollectionView = {
        let settingsLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: settingsLayout)
        cv.backgroundColor = .clear
        cv.register(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.id)
        cv.register(SettingsPremiumCell.self, forCellWithReuseIdentifier: SettingsPremiumCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.isScrollEnabled = true

        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        selectedCurrency = Currencies.shared.selectedCurrency.currency
        settingsCV.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationTitle(title: "Settings".localized(), large: true)
        
        settingsCV.delegate = self

        settingsCV.dataSource = self
        
        settingsSubviews()
    }
    
}
