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
    
    /// Глобальные массивы для хранения и отображения данных
    // Категории по типам операций
    var categoriesArr: [Category] = []
    // Операции, сортированные по месяцам
    var monthSections = [MonthSection]() {
        didSet {
            globalCV.reloadData()
        }
    }
    
    var categoryIsHidden: Bool = true
        
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
    let globalCV: UICollectionView = {
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
    
    var balanceLabel = UILabel(text: "Balance: 100,000.00 $")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        filterMonths()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Реагирование на события
        globalCV.delegate = self

        // Сюда подаются данные
        globalCV.dataSource = self
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter
        }()
        let string = "01/02/2016"
        let string2 = "12/08/2018"
        
        Records.shared.addNewOperation(record: Record(amount: 100, date: Date(), id: 0, type: .income, category: Category(name: "Salary", color: categoryColor.salaryColor!, image: UIImage(systemName: "dollarsign")!, type: .income)))
                 
        Records.shared.addNewOperation(record: Record(amount: -250, date: Date(), id: 1, type: .expense, category: Category(name: "Transport", color: categoryColor.transportColor!, image: UIImage(systemName: "car")!, type: .expense)))

        if let date = dateFormatter.date(from: string) {
            Records.shared.addNewOperation(record: Record(amount: 300, date: date, id: 2, type: .income, category: Category(name: "Pleasant finds", color: categoryColor.pleasantFindsColor!, image: UIImage(systemName: "heart")!, type: .income)))
            
            Records.shared.addNewOperation(record: Record(amount: 350, date: date, id: 3, type: .income, category: Category(name: "Pleasant finds", color: categoryColor.pleasantFindsColor!, image: UIImage(systemName: "heart")!, type: .income)))

            Records.shared.addNewOperation(record: Record(amount: -150, date: date, id: 4, type: .expense, category: Category(name: "Glocery", color: categoryColor.gloceryColor!, image: UIImage(systemName: "cart")!, type: .expense)))
        }
        if let date = dateFormatter.date(from: string2) {
            Records.shared.addNewOperation(record: Record(amount: 400, date: date, id: 5, type: .income, category: Category(name: "Debt repayment", color: categoryColor.debtRepaymentColor!, image: UIImage(systemName: "creditcard")!, type: .income)))

            Records.shared.addNewOperation(record: Record(amount: -450, date: date, id: 6, type: .expense, category: Category(name: "Service", color: categoryColor.serviceColor!, image: UIImage(systemName: "gear")!, type: .expense)))
        }
                                
        homeNavBar() // Кнопки в навбаре
        homeSubviews() // Отображение и размеры вьюшек
        homeButtonTargets() // Таргеты для кнопок
    }

}
