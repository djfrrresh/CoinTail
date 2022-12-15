//
//  ViewController.swift
//  CoinTail
//
//  Created by Eugene on 04.10.22.
//

import UIKit
import EasyPeasy
import Charts


struct Record {
    var amount: Double
    var descriptionText: String = ""
    var categoryText: String = ""
    var categoryImage: String = ""
    var date: Date
    var id: Int
    var type: RecordType
}

class HomeViewController: UIViewController {
    
    // Переменная, задающая таблицы
    let tableView = UITableView()
    // Круговая диаграмма, показывающая наглядно сумму операций
    var pieChart = PieChartView()
    
    var entries: [ChartDataEntry] = [] // Массив записей в диаграмме

    let balanceLabel = UILabel()
    let incomeBalanceLabel = UILabel()
    let expenseBalanceLabel = UILabel()
    
    let noTransactionlabel = UILabel(text: "No Transaction Yet!", alignment: .center)
    let addTransactionLabel = UILabel(text: "Add a transaction ", alignment: .center)
    
    let switchButton: UISegmentedControl = {
        let switcher = UISegmentedControl(items: [RecordType.income.rawValue, RecordType.expense.rawValue])
        switcher.selectedSegmentIndex = 0
        return switcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.view.backgroundColor = .white
        self.title = "Home"
                                                                        
        self.navigationController?.navigationBar.tintColor = .black
        
        // При добавлении addtarget у кнопок и свитчеров появляется UIControl, который работает всегда, как только кнопка / свитчер добавляется на экран
        self.switchButton.addTarget(self, action: #selector(switchButtonAction), for: .valueChanged)
        
        self.view.addSubview(noTransactionlabel)
        self.view.addSubview(addTransactionLabel)
        self.noTransactionlabel.easy.layout(CenterX(), Top(100))
        self.addTransactionLabel.easy.layout(Top(150), CenterX(), Width(200))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureItems() // Кнопка "+"
        self.setTableView() // Настройки для таблицы
        self.setChartView() // Настройки для диаграммы
        self.filterArray() // Сортировка массива в таблице
        self.setStack() // Стаки с расположением объектов на экране
        self.setChart() // Вывод данных на диаграмму
    }
    
    // viewDidLayoutSubviews используется для изменений с констреинтами и визуальной частью
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.emptyData() // Вывод сообщения о добавлении операции, если таблица пустая
    }
    
    var currentSegmentType: RecordType {
        return RecordType(rawValue: switchButton.titleForSegment(at: switchButton.selectedSegmentIndex)!)!
    }
}
