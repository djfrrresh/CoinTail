//
//  PieChartFunctions.swift
//  CoinTail
//
//  Created by Eugene on 23.12.22.
//

import UIKit
import EasyPeasy
import Charts


extension PieChartViewController {
    
    func sendNewOperation(switchButtonValue: String) {
        print("switchButtonValue PieChartVC: \(switchButtonValue)")

        switchValue = switchButtonValue
    }
    
    // Делегаты и расположение диаграммы
    func setChartView() {
        pieChart.delegate = self
        
        configureChart(pieChart)
        
        self.view.addSubview(self.pieChart)
        self.pieChart.easy.layout([Height(300), Width(300), CenterX(0), CenterY(0)])
    }
    
    // Вывод данных на диаграмму
    func setChart() {
        entries.removeAll()

        // Выводит записи по выбранному типу
        for entry in Storage.shared.records[currentSegmentType]! {
            // Преобразование в положительное число
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
    
    // Принимает все записи диаграммы для их отображения
    func updateSorting(values: [ChartDataEntry]){
        let dataSet = PieChartDataSet(entries: values, label: "")
        let data = PieChartData(dataSets: [dataSet])
        
        dataSet.colors = ChartColorTemplates.pastel()
        pieChart.data = data
        pieChart.notifyDataSetChanged()
        
        formatDataSet(dataSet)
    }
    
}
