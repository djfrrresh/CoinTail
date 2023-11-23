//
//  BudgetsVC.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit


class BudgetsVC: BasicVC {
        
    var budgets: [BudgetClass] {
        get {
            return RealmService.shared.budgetsArr
        }
    }
    
    let emptyBudgetsView = UIView()

    let targetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "targetEmoji")
        
        return imageView
    }()
    
    let noBudgetsLabel: UILabel = {
        let label = UILabel()
        label.text = "You have no budgets set up".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    let budgetsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Here you can set up a budgets for different categories and time periods".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }()
    
    let addBudgetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitle("Add a budget".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
    
    let budgetCV: UICollectionView = {
        let budgetLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0

            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: budgetLayout)
        cv.backgroundColor = .clear
        cv.contentInset = .init(top: 32, left: 0, bottom: 0, right: 0) // Отступ сверху
        cv.register(BudgetCell.self, forCellWithReuseIdentifier: BudgetCell.id)
        cv.register(BudgetCVHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BudgetCVHeader.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delaysContentTouches = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        budgetCV.reloadData()
        
        isBudgetEmpty()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationTitle(title: "Budgets".localized(), large: true)

        budgetCV.dataSource = self
        
        budgetCV.delegate = self
        
        budgetSubviews()
        emptyBudgetsSubviews()
        budgetButtonTargets()
    }
    
}
