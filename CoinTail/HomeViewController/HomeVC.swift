//
//  ViewController.swift
//  CoinTail
//
//  Created by Eugene on 04.10.22.
//

import UIKit
import EasyPeasy


// Структура ячейки для массива с ними
struct Record {
    var amount: Double
    var descriptionText: String = ""
    var categoryText: String = ""
    var categoryImage: String = ""
    var date: Date
    var id: Int
    var type: RecordType
}

// UIViewController согласно шаблону проектирования MVC обеспечивает взаимосвязь модели (Controller) и представления (View)
class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // Переменная, задающая таблицы
    let tableView = UITableView()
    
    weak var pieChartDelegate: HomeVCSendData?
        
    // Возвращает текущий выбранный тип
    var currentSegmentType: RecordType {
        return RecordType(rawValue: switchButton.titleForSegment(at: switchButton.selectedSegmentIndex)!)!
    }
    
    let balanceLabel = UILabel()
    let incomeBalanceLabel = UILabel()
    let expenseBalanceLabel = UILabel()
    
    var operationIsEmpty = UILabel()
    
    var operationName: String?
    
    let noTransactionlabel = UILabel(text: """
No Transaction Yet.
Add first transaction
""", alignment: .center)
    
    let balanceView = UIView()
    let incomeView = UIView()
    let expenceView = UIView()
        
    let addTransactionButton: UIButton = {
        let button = UIButton(name: "Add transaction")
        return button
    }()
    let chartViewButton: UIButton = {
        let button = UIButton(name: "Pie Chart")
        return button
    }()
    let switchButton: UISegmentedControl = {
        let switcher = UISegmentedControl(items: [RecordType.income.rawValue, RecordType.expense.rawValue])
        switcher.selectedSegmentIndex = 0
        return switcher
    }()
    
    var progressView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return view
    }()
    
    // viewDidLoad вызывается только при первой загрузке контроллера представления — после этого оно остается в памяти
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.view.backgroundColor = .white
        self.title = "Home"
                                                                                
        self.navigationController?.navigationBar.tintColor = .black
        
        self.noTransactionlabel.numberOfLines = 0
        self.operationIsEmpty.numberOfLines = 0
        
        self.configureItems() // Кнопка "+"
        self.buttonTargets() // Таргеты для кнопок
        self.subviews() // Отображение и размеры вьюшек
        
        // Привязка функций кнопки к UIView
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.pieChartAction))
        progressView.addGestureRecognizer(tap)
        
        view.bringSubviewToFront(addTransactionButton)
    }
    
    // Если нужно обновить содержимое в контроллере представления, используется viewWillAppear
    // Так как он вызывается каждый раз, когда появляется представление
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setTableView() // Настройки для таблицы
        self.filterArray() // Сортировка массива в таблице
        self.setStack() // Стаки с расположением объектов на экране
    }

    // viewDidLayoutSubviews используется для изменений с констреинтами и визуальной частью
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.emptyData() // Вывод сообщения о добавлении операции, если таблица пустая
    }
}

protocol HomeVCSendData: AnyObject {
    func sendNewOperation(switchButtonValue: String)
}
