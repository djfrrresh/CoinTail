//
//  BudgetsVC.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit
import EasyPeasy


final class BudgetsVC: BasicVC {
        
    var budgets: [BudgetClass] {
        get {
            return RealmService.shared.budgetsArr
        }
    }
        
    static let noBudgetsText = "You have no budgets set up"
    static let budgetsDescriptionText = "Here you can set up a budgets for different categories and time periods. Control your expenses now"
    
    let noBudgetsLabel: UILabel = getNoDataLabel(text: noBudgetsText)
    let budgetsDescriptionLabel: UILabel = getDataDescriptionLabel(text: budgetsDescriptionText)
    let budgetsImageView: UIImageView = getDataImageView(name: "targetEmoji")
    let addBudgetButton: UIButton = getAddDataButton(text: "Add a budget")
    
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

    //TODO: не выполняется подсчет суммы при смене валюты 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        budgetCV.reloadData()
        
        areBudgetsEmpty()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        customNavBar.titleLabel.text = "Budgets".localized()
                
        budgetCV.dataSource = self
        
        budgetCV.delegate = self
        
        budgetSubviews()
        budgetButtonTargets()
        emptyDataSubviews(
            dataImageView: budgetsImageView,
            noDataLabel: noBudgetsLabel,
            dataDescriptionLabel: budgetsDescriptionLabel,
            addDataButton: addBudgetButton
        )
    }
    
}
