//
//  HomeVC.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit
import Charts
import MultipleProgressBar


class HomeVC: BasicVC, SelectedDate {
    
    func selected(period: Periods) {
        self.period = period
        currentStep = 0
        
        filterMonths()
    }
    
    var period: Periods = .allTheTime {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
    
    // Операции, сортированные по месяцам
    var monthSections = [MonthSection]() {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
    
    // Категории по типам операций
    var categoriesArr: [Category] = []
    
    // Выбранная категория
    var categorySort: Category? {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
    
    var categoryIsHidden: Bool = true
    
    var currentStep: Int = 0 {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
            
    let categoryColor = Colors.shared
    
    // Переключатель типов операций
    let homeTypeSwitcher: UISegmentedControl = {
        var segmentedControl = UISegmentedControl(items: [
            RecordType.allOperations.rawValue,
            RecordType.income.rawValue,
            RecordType.expense.rawValue
        ])
        // Выбранный по умолчанию сегмент
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    // Возвращает операции по выбранному типу
    var homeSegment: RecordType = .allOperations
    
    // Глобальная коллекция, содержащая выбор даты, диаграммы и операции
    let homeGlobalCV: UICollectionView = {
        let operationLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: operationLayout)
        cv.backgroundColor = .clear
        // Регистрация трех ячеек коллекции
        cv.register(HomeOperationCell.self, forCellWithReuseIdentifier: HomeOperationCell.id)
        cv.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.id)
        cv.register(HomeDateCell.self, forCellWithReuseIdentifier: HomeDateCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.delaysContentTouches = true
        return cv
    }()
    
    var balanceLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        period = .allTheTime
        filterMonths()
        homeNavBar() // Кнопки в навбаре
        homeButtonTargets() // Таргеты для кнопок
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Реагирование на события
        homeGlobalCV.delegate = self

        // Сюда подаются данные
        homeGlobalCV.dataSource = self
                                        
        homeSubviews() // Отображение и размеры вьюшек
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter
        }()
        let string = "01/02/2019"
        let string2 = "12/08/2021"
        let string3 = "27/05/2023"
                
        Records.shared.addRecord(record: Record(amount: 100, date: Date(), id: 0, type: .income, category: Category(name: "Salary", color: categoryColor.salaryColor!, image: UIImage(systemName: "dollarsign")!, type: .income)))

        Records.shared.addRecord(record: Record(amount: -250, date: Date(), id: 1, type: .expense, category: Category(name: "Transport", color: categoryColor.transportColor!, image: UIImage(systemName: "car")!, type: .expense)))

        if let date = dateFormatter.date(from: string) {
            Records.shared.addRecord(record: Record(amount: 300, date: date, id: 2, type: .income, category: Category(name: "Pleasant finds", color: categoryColor.pleasantFindsColor!, image: UIImage(systemName: "heart")!, type: .income)))

            Records.shared.addRecord(record: Record(amount: 350, date: date, id: 3, type: .income, category: Category(name: "Pleasant finds", color: categoryColor.pleasantFindsColor!, image: UIImage(systemName: "heart")!, type: .income)))

            Records.shared.addRecord(record: Record(amount: -150, date: date, id: 4, type: .expense, category: Category(name: "Glocery", color: categoryColor.gloceryColor!, image: UIImage(systemName: "cart")!, type: .expense)))
        }
        if let date = dateFormatter.date(from: string2) {
            Records.shared.addRecord(record: Record(amount: 400, date: date, id: 5, type: .income, category: Category(name: "Debt repayment", color: categoryColor.debtRepaymentColor!, image: UIImage(systemName: "creditcard")!, type: .income)))

            Records.shared.addRecord(record: Record(amount: -450, date: date, id: 6, type: .expense, category: Category(name: "Service", color: categoryColor.serviceColor!, image: UIImage(systemName: "gear")!, type: .expense)))
        }
        if let date = dateFormatter.date(from: string3) {
            Records.shared.addRecord(record: Record(amount: 500, date: date, id: 7, type: .income, category: Category(name: "Salary", color: categoryColor.salaryColor!, image: UIImage(systemName: "dollarsign")!, type: .income)))

            Records.shared.addRecord(record: Record(amount: -550, date: date, id: 8, type: .expense, category: Category(name: "Subscription", color: categoryColor.subscriptionColor!, image: UIImage(systemName: "gamecontroller")!, type: .expense)))
        }

    }

}
