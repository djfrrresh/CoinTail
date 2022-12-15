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
    
    // Делегаты и расположение таблицы
    func setTableView() {
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "HomeCustomCell")
        self.tableView.delegate = self // Реагирование на события
        self.tableView.dataSource = self // Здесь подаются данные
        
        self.tableView.easy.layout([Height(300)])
    }
    
    // Делегаты и расположение диаграммы 
    func setChartView() {
        pieChart.delegate = self
        
        configureChart(pieChart)
        
        self.pieChart.easy.layout([Height(300)])
    }
    
    // Вывод данных на диаграмму
    func setChart() {
        entries.removeAll()
        for entry in Storage.shared.records[currentSegmentType]! {
            let amount = entry.amount * (currentSegmentType == .expense ? -1 : 1)
            let dataEntry = PieChartDataEntry(value: amount, label: entry.type.rawValue)
            entries.append(dataEntry) // Добавление записи
        }

        updateSorting(values: entries)
        pieChart.centerText = """
            \(currentSegmentType.rawValue)
            \(Storage.shared.balance(currentSegmentType))
            """
    }
    
    func updateSorting(values: [ChartDataEntry]){
        let dataSet = PieChartDataSet(entries: values, label: "")
        let data = PieChartData(dataSets: [dataSet])
        
        dataSet.colors = ChartColorTemplates.colorful()
        pieChart.data = data
        pieChart.notifyDataSetChanged()
        
        formatDataSet(dataSet)
    }
    
    // Вывод сообщения о том, что нужно добавить запись, чтобы вывелись объекты экрана
    func emptyData() {
        tableView.isHidden = Storage.shared.records[.income]!.isEmpty && Storage.shared.records[.expense]!.isEmpty
        pieChart.isHidden = tableView.isHidden
        balanceLabel.isHidden = tableView.isHidden
        incomeBalanceLabel.isHidden = tableView.isHidden
        expenseBalanceLabel.isHidden = tableView.isHidden
        switchButton.isHidden = tableView.isHidden
        noTransactionlabel.isHidden = !tableView.isHidden
        addTransactionLabel.isHidden = !tableView.isHidden
    }

    // Настройки для текста
    func setLabel(label: UILabel, text: String, fontSize: CGFloat, alignment: NSTextAlignment) {
        label.text = text
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: fontSize)
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
