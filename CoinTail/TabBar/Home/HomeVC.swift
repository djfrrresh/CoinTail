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
    }

}
