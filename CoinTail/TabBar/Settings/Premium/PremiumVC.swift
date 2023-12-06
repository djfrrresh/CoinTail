//
//  PremiumVC.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

import UIKit


final class PremiumVC: BasicVC {
    
    let buttonBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let buyPremiumButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        //TODO: button text
        button.setTitle("Continue - total 1200 RUB".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
    
    let premiumCV: UICollectionView = {
        let premiumLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: premiumLayout)
        cv.backgroundColor = .clear
        cv.register(SettingsCell.self, forCellWithReuseIdentifier: SettingsCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.isScrollEnabled = true

        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CoinTail Premium".localized()
        
//        premiumCV.delegate = self

        premiumCV.dataSource = self
        
        premiumSubviews()
    }
    
}
