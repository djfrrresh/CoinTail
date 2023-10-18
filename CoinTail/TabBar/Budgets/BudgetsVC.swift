//
//  BudgetsVC.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit


class BudgetsVC: BasicVC {
        
    // Массив бюджетов с сортировкой по дням
    var daySections = [DaySection]() {
        didSet {
            budgetCV.reloadData()
        }
    }
    
    let budgetCV: UICollectionView = {
        let budgetLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: budgetLayout)
        cv.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0) // Отступ сверху
        cv.backgroundColor = .clear
        cv.register(BudgetCell.self, forCellWithReuseIdentifier: BudgetCell.id)
        cv.register(BudgetCVHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BudgetCVHeader.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true // Подпрыгивание коллекции
        
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        budgetNavBar()
        sortBudgets() // Сортировка бюджетов по убыванию по дате
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Budgets".localized()
                
        budgetCV.dataSource = self
        
        budgetCV.delegate = self
        
        budgetSubviews()
    }
    
}
