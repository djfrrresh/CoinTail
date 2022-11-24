//
//  ViewController.swift
//  CoinTail
//
//  Created by Eugene on 04.10.22.
//

import UIKit
import EasyPeasy


class HomeViewController: UIViewController {
    
    // Переменная, задающая таблицы
    let tableView = UITableView()
    // Массив таблицы, содержимое которого редактируем
    var cellArr = [String]()
    
    var amountText: String = ""
    var descriptionText: String = ""
    var categoryText: String = ""
    var categoryImage: String = ""
    var dateText: String = ""
    
    let balance = UILabel()
    var balanceScore: Int = 0 // Общий баланс
    let incomeBalance = UILabel()
    var incomeBalanceScore: Int = 0 // Пополнения
    let expenseBalance = UILabel()
    var expenseBalanceScore: Int = 0 // Траты
    
    func setBalanceText(label: UILabel, fontSize: CGFloat, text: String) {
        label.font = .systemFont(ofSize: fontSize)
        label.text = text
        view.addSubview(label)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureItems() // Кнопка "+"
        
        self.view.backgroundColor = .white
        self.title = "Home"
        
        setBalanceText(label: balance, fontSize: 30, text: "Your Balance: \(balanceScore)")
        setBalanceText(label: incomeBalance, fontSize: 20, text: "Your Income: \(incomeBalanceScore)")
        setBalanceText(label: expenseBalance, fontSize: 20, text: "Your Expense: \(expenseBalanceScore)")
        
        balance.easy.layout(Top(20).to(view.safeAreaLayoutGuide, .top), CenterX(0))
        incomeBalance.easy.layout(Top(50).to(balance, .top), Left(16))
        expenseBalance.easy.layout(Top(50).to(balance, .top), Right(16))
                
        setTableView() // Настройки для таблицы
                
        self.navigationController?.navigationBar.tintColor = .black
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
