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
    
    let emptyOperationsView = UIView()

    let graphicsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "graphicsEmoji")
        
        return imageView
    }()
    
    let noOperationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Start adding your expenses and income".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    let operationsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Manage your finances by tracking your expenses and income via different categories".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }()
    
    let addOperationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitle("Add a transaction".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()

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
        homeButtonTargets()
        isOperationsEmpty()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                        
        homeGlobalCV.delegate = self

        homeGlobalCV.dataSource = self
                        
        emptyOperationsSubviews()
        homeSubviews()
    }

}
