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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureItems() // Кнопка "+"
        
        self.view.backgroundColor = .white.withAlphaComponent(0.9)
        self.title = "Home"
        self.balance.font = .systemFont(ofSize: 30) // Размер текста
        
        self.balance.text = "Your Balance: \(balanceScore)"
        
        self.view.addSubview(balance)
        balance.easy.layout([
            CenterX(0),
            CenterY(-300)
        ])
        
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
