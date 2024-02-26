//
//  SettingsVC.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavBar.titleLabel.text = "Settings".localized()
        customNavBar.customButton.isHidden = true

        navigationController?.delegate = self
        settingsCV.delegate = self

        settingsCV.dataSource = self
        
        settingsSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        selectedCurrency = Currencies.shared.selectedCurrency.currency
        settingsCV.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
}
