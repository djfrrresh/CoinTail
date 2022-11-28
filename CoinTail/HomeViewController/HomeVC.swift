//
//  ViewController.swift
//  CoinTail
//
//  Created by Eugene on 04.10.22.
//

import UIKit
import EasyPeasy


struct Record {
    var amount: Float
    var descriptionText: String = ""
    var categoryText: String = ""
    var categoryImage: String = ""
    var date: Date
}

struct Balance {
    var balanceScore: Float = 0 // Общий баланс
    var incomeBalanceScore: Float = 0 // Пополнения
    var expenseBalanceScore: Float = 0 // Траты
}

class HomeViewController: UIViewController {
    
    // Переменная, задающая таблицы
    let tableView = UITableView()
    // Массив таблицы, содержимое которого выводим в ячейках, принимает значения из структуры
    var cellArr = [Record]()

    let balanceLabel = UILabel()
    let incomeBalanceLabel = UILabel()
    let expenseBalanceLabel = UILabel()
    
    var balanceStruct = Balance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureItems() // Кнопка "+"
        
        self.view.backgroundColor = .white
        self.title = "Home"
                                                                        
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    
    func setBalanceText(label: UILabel, fontSize: CGFloat, text: String) {
        label.font = .systemFont(ofSize: fontSize)
        label.text = text
        view.addSubview(label)
    }
    
    func setBalance() {
        setBalanceText(label: balanceLabel, fontSize: 30, text: "Your Balance: \(balanceStruct.balanceScore)")
        setBalanceText(label: incomeBalanceLabel, fontSize: 20, text: "Your Income: \(balanceStruct.incomeBalanceScore)")
        setBalanceText(label: expenseBalanceLabel, fontSize: 20, text: "Your Expense: \(balanceStruct.expenseBalanceScore)")
        
        balanceLabel.easy.layout(Top(20).to(view.safeAreaLayoutGuide, .top), CenterX(0))
        incomeBalanceLabel.easy.layout(Top(50).to(balanceLabel, .top), Left(16))
        expenseBalanceLabel.easy.layout(Top(50).to(balanceLabel, .top), Right(16))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setTableView() // Настройки для таблицы
        self.setBalance()
        self.filteredArray()
    }
    
    // Отсортировать массив по дате
    func filteredArray() {
        self.cellArr.sort { l, r in
            print(l, r)
            return l.date < r.date
        }
        self.tableView.reloadData()
    }
    
    // Кнопка "Добавить" в углу экрана
    private func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (AddNewOperation)
        )
    }
    
    // Переход на VC с добавлением операции
    @objc func AddNewOperation() {
        let vc = AddNewOperationVC(homeViewController: self)
        vc.addNewOpDelegate = self // Связь с контроллером, откуда передаются данные
        
        navigationController?.pushViewController(vc, animated: true)
    }

}
