//
//  SettingsVC.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit


class SettingsVC: BasicVC {
    
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
    
    var selectedCurrency: String?
    
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
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.delaysContentTouches = true
        
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedCurrency = "\(Currencies.shared.selectedCurrency)"
        settingsCV.reloadData()
        
        //TODO: пофиксить переход с large title 
        if let navigationController = self.navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.prefersLargeTitles = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings".localized()
        
        settingsCV.delegate = self

        settingsCV.dataSource = self
        
        settingsSubviews()
    }
    
}
