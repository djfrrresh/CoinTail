//
//  HomeVC.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit
import Charts


final class HomeVC: BasicVC {
    
    var period: DatePeriods = .allTheTime {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
    
    // Операции, записанные в массив по месяцам
    var monthSections = [OperationsDaySection]() {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
    
    // Категории по типам операций
    var categoriesByType: [CategoryClass] = []
    // Выбранная категория
    var categorySort: CategoryClass? {
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
    
    static let noOperationsText = "Start adding your expenses and income"
    static let operationsDescriptionText = "Manage your finances by tracking your expenses and income via different categories"
    
    let noOperationsLabel: UILabel = getNoDataLabel(text: noOperationsText)
    let operationsDescriptionLabel: UILabel = getDataDescriptionLabel(text: operationsDescriptionText)
    let operationsImageView: UIImageView = getDataImageView(name: "graphicsEmoji")
    let addOperationButton: UIButton = getAddDataButton(text: "Add a transaction")

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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("ExchangeRatesUpdated"), object: nil)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        period = .allTheTime
        
        sortOperations() // Сортировка операций по убыванию по дате
        homeButtonTargets()
        areOperationsEmpty()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleExchangeRatesUpdated), name: Notification.Name("ExchangeRatesUpdated"), object: nil)
        
        customNavBar.subTitleLabel.text = "Balance".localized()
                                
        homeGlobalCV.delegate = self

        homeGlobalCV.dataSource = self
        
        homeSubviews()
        emptyDataSubviews(
            dataImageView: operationsImageView,
            noDataLabel: noOperationsLabel,
            dataDescriptionLabel: operationsDescriptionLabel,
            addDataButton: addOperationButton
        )
    }

}
