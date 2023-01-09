//
//  HomeFuncs.swift
//  CoinTail
//
//  Created by Eugene on 08.12.22.
//

import UIKit
import EasyPeasy
import Charts


extension HomeViewController {
    
    func buttonTargets() {
        // При добавлении addtarget у кнопок и свитчеров появляется UIControl, который работает всегда, как только кнопка / свитчер добавляется на экран
        self.switchButton.addTarget(self, action: #selector(switchButtonAction), for: .valueChanged)
        self.addTransactionButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        self.chartViewButton.addTarget(self, action: #selector(pieChartAction), for: .touchUpInside)
    }
    
    func subviews() {
        self.setButton(button: self.chartViewButton, background: .black, textColor: .white)

        self.view.addSubview(self.addTransactionButton)
        self.addTransactionButton.easy.layout([Height(56), Left(16), Right(16), Bottom(16).to(view.safeAreaLayoutGuide, .bottom)])
        
        self.view.addSubview(noTransactionlabel)
        self.noTransactionlabel.easy.layout([CenterX(), CenterY()])
        
        self.setButton(button: self.addTransactionButton, background: .black, textColor: .white)
    }
    
    // Делегаты и расположение таблицы
    func setTableView() {
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "HomeCustomCell")
        self.tableView.delegate = self // Реагирование на события
        self.tableView.dataSource = self // Здесь подаются данные
    }
    
    // Вывод сообщения о том, что нужно добавить запись, чтобы вывелись объекты экрана
    func emptyData() {
        tableView.isHidden = Storage.shared.records[.income]!.isEmpty && Storage.shared.records[.expense]!.isEmpty
        incomeBalanceLabel.isHidden = tableView.isHidden
        expenseBalanceLabel.isHidden = tableView.isHidden
        switchButton.isHidden = tableView.isHidden
        balanceLabel.isHidden = tableView.isHidden
        progressView.isHidden = tableView.isHidden
        operationIsEmpty.isHidden = tableView.isHidden
        noTransactionlabel.isHidden = !tableView.isHidden
        addTransactionButton.isHidden = !tableView.isHidden
    }
    
    // Настройки для кнопки
    func setButton(button: UIButton, background: UIColor, textColor: UIColor) {
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        
        button.backgroundColor = background
        button.layer.borderColor = UIColor.black.cgColor
        
        button.setTitleColor(textColor, for: .normal)        
    }
    
    func setEmptyOperationsLabel() {
        if (Storage.shared.records[currentSegmentType]!.isEmpty) {
            if currentSegmentType == .income {
                operationName = """
                You have not yet
                received incomes
                """
            }
            if currentSegmentType == .expense {
                operationName = """
                You haven't had
                any expenses yet
                """
            }
            operationIsEmpty.text = operationName
            
            self.view.addSubview(operationIsEmpty)
            self.operationIsEmpty.easy.layout([CenterY(100), CenterX()])
        } else {
            operationIsEmpty.isHidden = true
        }
    }

    // Настройки для текста
    func setLabel(label: UILabel, text: String, fontSize: CGFloat) {
        label.text = text
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: fontSize)
        
        label.textAlignment = .center
    }
    
    // Отсортировать массив по дате
    func filterArray() {
        Storage.shared.records[currentSegmentType]!.sort { l, r in
            return l.date < r.date
        }
        self.tableView.reloadData()
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
    
    // Кнопка "Добавить" в углу экрана
    func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (AddNewOperation)
        )
    }
    
}
