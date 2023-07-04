//
//  ChartsSetEntries.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit
import Charts
import MultipleProgressBar


extension HomeCategoryCell {
    
    // Добавляет запись в круговую и плоскую диаграммы
    func setEntries(_ segment: RecordType, records: [Record]) {
        // Стирает прошлые записи
        pieChartEntries.removeAll()
        progressChartEntries.removeAll()
        pieChartColors.removeAll()
        
        // Секции == категории, по которым идет сортировка
        let chartSections = setDictionary(segment, records: records)

        for (entry, _) in chartSections {
            var sum: Double = 0
                        
            // Перебор операций по категориям
            for i in 0..<(chartSections[entry]!.count) {
                // Преобразование в положительное число
                let amount = abs(chartSections[entry]![i].amount)
                // Сумма всех операций в данной категории
                sum += amount
            }
            
            // Добавление записей и цветов в диаграммы
            switch segment {
            case .expense, .income:
                // Цвет берется из категории в операции
                let color: UIColor = chartSections[entry]?.first?.category.color ?? .black
                    
                pieChartColors.append(color)
                
                let progressBarEntry = UsagesModel(color: color, value: sum)
                progressChartEntries.append(progressBarEntry)
            case .allOperations:
                // Цвет берется по типу операции
                let color: UIColor? = chartSections[entry]![0].type == .expense ? UIColor(named: "expense") : UIColor(named: "income")
                
                pieChartColors.append(color ?? .black)
                
                let progressBarEntry = UsagesModel(color: color ?? .black, value: sum)
                progressChartEntries.append(progressBarEntry)
            }
            
            let pieChartEntry = PieChartDataEntry(value: sum, label: "")
            pieChartEntries.append(pieChartEntry) // Добавление записи
        }
    
    }
    
    // Устанавливаем словарь, который будем перебирать для получения цветов и суммы операций
    private func setDictionary(_ segment: RecordType, records: [Record]) -> [String: [Record]] {
        return Dictionary(grouping: records, by: {
            segment == .allOperations ? $0.category.type?.rawValue ?? "Total" : $0.category.name
        })
    }
    
}
