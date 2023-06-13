//
//  ChartsSetEntries.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit
import Charts
import MultipleProgressBar


extension HomeVC {
    
    // Добавляет запись в круговую и плоскую диаграммы
    func setEntries() {
        // Стирает прошлые записи
        pieChartEntries.removeAll()
        progressValues.removeAll()
        
        // Секции == категории, по которым идет сортировка
        var chartSections: [String: [Record]]
        
        if segment == .allOperations {
            chartSections = Dictionary(grouping: Records.shared.records[.allOperations]!, by: {
                $0.type.rawValue
            })
        } else {
            chartSections = Dictionary(grouping: Records.shared.records[segment]!, by: {
                $0.categoryText
            })
        }

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
            if (segment == .allOperations) {
                var color: UIColor?
                                
                // Цвет берется по типу операции
                switch chartSections[entry]![0].type {
                case .expense:
                    color = UIColor(named: "expense")
                case .income:
                    color = UIColor(named: "income")
                default:
                    color = .black
                }
                
                pieChartColors.append(color ?? .black)
                
                let progressBarEntry = UsagesModel(color: color ?? .black, value: sum)
                progressValues.append(progressBarEntry)
            } else {
                // Цвет берется из самой операции
                let color: UIColor = (Records.shared.records[segment]!.first(
                    where: {
                        $0.categoryText == entry
                    })
                )?.categoryColor ?? .black
                    
                pieChartColors.append(color)
                
                let progressBarEntry = UsagesModel(color: color, value: sum)
                progressValues.append(progressBarEntry)
            }
            
            let pieChartEntry = PieChartDataEntry(value: sum, label: nil)
            pieChartEntries.append(pieChartEntry) // Добавление записи
        }
    
    }
    
}
