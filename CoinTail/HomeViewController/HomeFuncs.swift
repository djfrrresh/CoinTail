//
//  HomeFuncs.swift
//  CoinTail
//
//  Created by Eugene on 08.12.22.
//

import UIKit
import EasyPeasy


extension HomeViewController {
    
    // Делегаты и расположение таблицы
    func setTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "HomeCustomCell")
        self.tableView.delegate = self // Реагирование на события
        self.tableView.dataSource = self // Здесь подаются данные
        
        self.tableView.easy.layout([
            Left(0),
            Right(0),
            Height(400),
            CenterX(0),
            Bottom(0)
        ])
    }
    
    // Проверка на сегодняшнюю дату
    func checkToDay(date: Date, textField: UITextField) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let toDay = Date()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if (dateFormatter.string(from: (date)) == dateFormatter.string(from: (toDay))) {
            textField.text = "Today \(dateFormatter.string(from: date))"
        } else {
            textField.text = dateFormatter.string(from: date)
        }
    }
    
}
