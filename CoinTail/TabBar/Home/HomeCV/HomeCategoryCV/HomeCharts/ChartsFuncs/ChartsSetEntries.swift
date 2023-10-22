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
    func setEntries(_ segment: RecordType, records: [RecordClass]) {
        // Стирает прошлые записи
        pieChartEntries.removeAll()
        progressChartEntries.removeAll()
        pieChartColors.removeAll()
        
        // Секции == категории, по которым идет сортировка
        let chartSections = setDictionary(segment, records: records)
        
        for (_, chartSectionsEntry) in chartSections {
            var sum: Double = 0
            let color: UIColor?
            
            if segment == .expense || segment == .income {
                // Цвет берется из категории в операции
                guard let categoryID = chartSectionsEntry.first?.categoryID else { return }
                let category = Categories.shared.getCategory(for: categoryID)

                color = UIColor(hex: category?.color ?? "FFFFFF")
            } else {
                // Цвет берется по типу операции
                color = chartSectionsEntry.first?.type == "Expense" ? UIColor(named: "expense") : UIColor(named: "income")
            }

            // Смена итерации, если цвет не найден
            guard let chartColor = color else { continue }

            pieChartColors.append(chartColor)

            for i in 0..<chartSectionsEntry.count {
                // Преобразование в положительное число
                let amount = abs(chartSectionsEntry[i].amount)
                // Сумма всех операций в данной категории
                sum += amount
            }

            // Добавление записи в диаграммы
            let progressBarEntry = UsagesModel(color: chartColor, value: sum)
            progressChartEntries.append(progressBarEntry)

            let pieChartEntry = PieChartDataEntry(value: sum, label: "")
            pieChartEntries.append(pieChartEntry)
        }
    }
    
    // Устанавливаем словарь, который будем перебирать для получения цветов и суммы операций
    private func setDictionary(_ segment: RecordType, records: [RecordClass]) -> [String: [RecordClass]] {
        Dictionary(grouping: records, by: {
            guard let category = Categories.shared.getCategory(for: $0.categoryID) else { return "" }
            
            return segment.rawValue == "Total" ? category.type ?? "Total" : category.name
        })
    }
    
}
