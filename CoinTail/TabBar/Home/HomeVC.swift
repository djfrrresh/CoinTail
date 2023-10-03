//
//  HomeVC.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit
import Charts
import MultipleProgressBar


class HomeVC: BasicVC {
    
    var period: DatePeriods = .allTheTime {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
    
    // Операции, записанные в массив по месяцам
    var monthSections = [MonthSection]() {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
    
    // Категории по типам операций
    var categoriesByType: [Category] = []
    
    // Выбранная категория
    var categorySort: Category? {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
        
    var currentStep: Int = 0 {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
             
    var categoryIsHidden: Bool = true

    // Переключатель типов операций
    let homeTypeSwitcher: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            RecordType.allOperations.rawValue.localized(),
            RecordType.income.rawValue.localized(),
            RecordType.expense.rawValue.localized()
        ])
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    // Используется для возврата операций по выбранному типу
    var homeSegment: RecordType = .allOperations
    
    // Глобальная коллекция, содержащая выбор даты, диаграммы и операции
    let homeGlobalCV: UICollectionView = {
        let globalLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8

            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: globalLayout)
        cv.backgroundColor = .clear
        cv.register(HomeOperationCell.self, forCellWithReuseIdentifier: HomeOperationCell.id)
        cv.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.id)
        cv.register(HomeDateCell.self, forCellWithReuseIdentifier: HomeDateCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
    
    let balanceLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        period = .allTheTime
        sortRecords() // Сортировка операций по убыванию по дате
        homeNavBar() // Кнопки в навбаре
        homeButtonTargets() // Таргеты для кнопок
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        homeGlobalCV.delegate = self // Реагирование на события

        homeGlobalCV.dataSource = self // Подача данных
                                        
        homeSubviews() // Отображение и размеры вьюшек
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            return formatter
        }()
        let string = "01/02/2019"
        let string2 = "15/08/2021"
        let string3 = "27/05/2023"
                
        let categoryColor = Colors.shared

        Records.shared.addRecord(
            record: Record(
                amount: 100,
                date: Date(),
                id: 0,
                type: .income,
                categoryID: Categories.shared.categories[.income]![0].id,
                accountID: Accounts.shared.accounts[0].id,
                currency: Currency.EUR
            )
        )
        Records.shared.addRecord(
            record: Record(
                amount: -250,
                date: Date(),
                id: 1,
                type: .expense,
                categoryID: Categories.shared.categories[.expense]![0].id,
                accountID: Accounts.shared.accounts[2].id,
                currency: Currency.USD
            )
        )

        if let date = dateFormatter.date(from: string) {
            Records.shared.addRecord(
                record: Record(
                    amount: 300,
                    date: date,
                    id: 2,
                    type: .income,
                    categoryID: Categories.shared.categories[.income]![3].id,
                    accountID: Accounts.shared.accounts[1].id,
                    currency: Currency.EUR
                )
            )
            Records.shared.addRecord(
                record: Record(
                    amount: 350,
                    date: date,
                    id: 3,
                    type: .income,
                    categoryID: Categories.shared.categories[.income]![3].id,
                    accountID: Accounts.shared.accounts[1].id,
                    currency: Currency.RUB
                )
            )
            Records.shared.addRecord(
                record: Record(
                    amount: -150,
                    date: date,
                    id: 4,
                    type: .expense,
                    categoryID: Categories.shared.categories[.expense]![2].id,
                    accountID: Accounts.shared.accounts[0].id,
                    currency: Currency.USD
                )
            )
        }
        
        if let date = dateFormatter.date(from: string2) {
            Records.shared.addRecord(
                record: Record(
                    amount: 400,
                    date: date,
                    id: 5,
                    type: .income,
                    categoryID: Categories.shared.categories[.income]![1].id,
                    accountID: Accounts.shared.accounts[2].id,
                    currency: Currency.RUB
                )
            )
            
            Records.shared.addRecord(
                record: Record(
                    amount: -450,
                    date: date,
                    id: 6,
                    type: .expense,
                    categoryID: Categories.shared.categories[.expense]![4].id,
                    accountID: Accounts.shared.accounts[2].id,
                    currency: Currency.USD
                )
            )
        }
        
        if let date = dateFormatter.date(from: string3) {
            Records.shared.addRecord(
                record: Record(
                    amount: 500,
                    date: date,
                    id: 7,
                    type: .income,
                    categoryID: Categories.shared.categories[.income]![0].id,
                    accountID: Accounts.shared.accounts[0].id,
                    currency: Currency.USD
                )
            )
            Records.shared.addRecord(
                record: Record(
                    amount: -550,
                    date: date,
                    id: 8,
                    type: .expense,
                    categoryID: Categories.shared.categories[.expense]![5].id,
                    accountID: Accounts.shared.accounts[1].id,
                    currency: Currency.EUR
                )
            )
        }

    }

}
