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
    // Хранимые значения в линейной диаграмме
    var progressValues: [UsagesModel] = []
    // Массив записей в круговой диаграмме
    var pieChartEntries: [ChartDataEntry] = []
    // Цвета для круговой диаграммы
    var pieChartColors: [UIColor] = []
    // Категории по типам операций
    var categoriesArr: [HomeCVCategory] = [HomeCVCategory]()
    // Операции, сортированные по месяцам
    var monthSections = [MonthSection]() {
        didSet {
            globalCV.reloadData()
        }
    }
    
    let categoryColor = Colors.shared
    
    // Переключатель типов операций
    let typeSwitcher: UISegmentedControl = {
        var segment = UISegmentedControl(items: [
            RecordType.allOperations.rawValue,
            RecordType.income.rawValue,
            RecordType.expense.rawValue
        ])
        // Выбранный по умолчанию сегмент
        segment.selectedSegmentIndex = 0
        return segment
    }()
    // Возвращает операции по выбранному типу
    var segment: RecordType = .allOperations {
        didSet {
            switch segment {
            case .expense:
                monthSections = MonthSection.group(groupRecords: Records.shared.expenses)
            case .income:
                monthSections = MonthSection.group(groupRecords: Records.shared.incomes)
            case .allOperations:
                monthSections = MonthSection.group(groupRecords: Records.shared.total)
            }
        }
    }
    
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
                 
        sendNewOperation(id: nil, amount: 100, description: "test", category: "Salary", image: UIImage(systemName: "dollarsign")!, date: Date(), type: .income, color: categoryColor.salaryColor!)

        sendNewOperation(id: nil, amount: 250, description: "test4", category: "Transport", image: UIImage(systemName: "car")!, date: Date(), type: .expense, color: categoryColor.transportColor!)

        if let date = dateFormatter.date(from: string) {
            sendNewOperation(id: nil, amount: 300, description: "test3", category: "Pleasant finds", image: UIImage(systemName: "heart")!, date: date, type: .income, color: categoryColor.pleasantFindsColor!)
            sendNewOperation(id: nil, amount: 350, description: "test5", category: "Pleasant finds", image: UIImage(systemName: "heart")!, date: date, type: .income, color: categoryColor.pleasantFindsColor!)

            sendNewOperation(id: nil, amount: 150, description: "test2", category: "Glocery", image: UIImage(systemName: "cart")! , date: date, type: .expense, color: categoryColor.gloceryColor!)
        }
        if let date = dateFormatter.date(from: string2) {
            sendNewOperation(id: nil, amount: 400, description: "test6", category: "Debt repayment", image: UIImage(systemName: "creditcard")!, date: date, type: .income, color: categoryColor.debtRepaymentColor!)

            sendNewOperation(id: nil, amount: 450, description: "test7", category: "Service", image: UIImage(systemName: "gear")! , date: date, type: .expense, color: categoryColor.serviceColor!)
        }
                
        homeNavBar() // Кнопки в навбаре
        homeSubviews() // Отображение и размеры вьюшек
        homeButtonTargets() // Таргеты для кнопок
    }

}
