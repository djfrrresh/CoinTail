//
//  ViewController.swift
//  CoinTail
//
//  Created by Eugene on 04.10.22.
//

import UIKit
import EasyPeasy


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Переменная, задающая таблицы
    let tableView = UITableView()
    // Массив таблицы, содержимое которого редактируем
    var cellArr = [String]()
    
    let balance = UILabel()
    var balanceScore: Float = 0 // Общий баланс
//    var new_income_expense: Float = 0 // Траты/пополнения
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureItems() // Кнопка "+"
        
        self.view.addSubview(tableView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self // Реагирование на события
        self.tableView.dataSource = self // Здесь подаются данные
        
        self.view.backgroundColor = .white.withAlphaComponent(0.9)
        self.title = "Home"
        // Размер текста
        balance.font = .systemFont(ofSize: 30)
        
        self.balance.text = "Your Balance: \(balanceScore)"
        // Вызов текста
        self.view.addSubview(balance)
        // Расположение текста
        balance.easy.layout([
            CenterX(0),
            CenterY(-300)
        ])
        
        self.navigationController?.navigationBar.tintColor = .black
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.easy.layout([
            Left(0),
            Right(0),
            Height(300),
            CenterX(0),
            CenterY(150)
        ])
    }
    
    // Кнопка "Добавить" в углу экрана
    private func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (AddNewOperation)
        )
    }
    
    @objc func AddNewOperation() {
        let vc = AddNewOperationVC()
        navigationController?.pushViewController(vc, animated: true)
    }

}
