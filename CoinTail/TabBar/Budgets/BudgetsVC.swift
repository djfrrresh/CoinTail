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
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            return formatter
        }()
        let string = "12/08/2021"
        let stringUntil = "12/09/2021"
        let string1 = "27/05/2023"
        let stringUntil1 = "27/06/2023"
        
        let categoryColor = Colors.shared
        
        Budgets.shared.addNewBudget(
            Budget(
                categoryID: Categories.shared.categories[.expense]![4].id,
                amount: 500,
                startDate: dateFormatter.date(from: string)!,
                untilDate: dateFormatter.date(from: stringUntil)!,
                id: 0,
                currency: Currency.USD
            )
        )
        Budgets.shared.addNewBudget(
            Budget(
                categoryID: Categories.shared.categories[.expense]![2].id,
                amount: 1000,
                startDate: dateFormatter.date(from: string)!,
                untilDate: dateFormatter.date(from: stringUntil)!,
                id: 1,
                currency: Currency.RUB
            )
        )
        Budgets.shared.addNewBudget(
            Budget(
                categoryID: Categories.shared.categories[.expense]![0].id,
                amount: 200,
                startDate: dateFormatter.date(from: string1)!,
                untilDate: dateFormatter.date(from: stringUntil1)!,
                id: 2,
                currency: Currency.AED
            )
        )
    }
    
}
