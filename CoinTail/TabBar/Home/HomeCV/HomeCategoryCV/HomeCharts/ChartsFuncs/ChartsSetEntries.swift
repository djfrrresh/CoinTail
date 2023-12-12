//
//  ChartsSetEntries.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit
import Charts
import RealmSwift


protocol ChartsDelegate: AnyObject {
    func updateCharts()
}

extension HomeCategoryCell {
    
    // Добавляет запись в круговую диаграмму
    func setEntries(_ segment: RecordType, records: [RecordClass]) {
        pieChartEntries.removeAll()
        pieChartColors.removeAll()
        
        // Секции это категории, по которым идет рассчет суммы из каждой операции
        let chartSections = setDictionary(segment, records: records)
                
        for (_, chartSectionsEntry) in chartSections {
            var sum: Double = 0
            
            sum = chartSectionsEntry.reduce(0, { zero, record in
                var result: Double = 0

                convertAmount(abs(record.amount), recordCurrency: record.currency) { convertedAmount in
                    result += convertedAmount ?? 0
                }
                                
                return zero + result
            })
            
            let pieChartEntry = PieChartDataEntry(value: sum, label: "")
            pieChartEntries.append(pieChartEntry)
            setColor(records: chartSectionsEntry, segment)
        }
    }
    
    private func convertAmount(_ amount: Double, recordCurrency: String, completion: @escaping (Double?) -> Void) {
        let selectedCurrency = Currencies.shared.selectedCurrency.currency

        let exchangeRates = ExchangeRateManager.shared.exchangeRates[selectedCurrency]

        guard let exchangeRates = exchangeRates,
              let exchangeRate = exchangeRates[recordCurrency] else {
            print("Failed to get exchangeRates")
            completion(nil)
            return
        }

        var convertedAmount: Double
        if selectedCurrency != recordCurrency {
            convertedAmount = amount / exchangeRate
        } else {
            convertedAmount = amount
        }

        completion(convertedAmount)
    }
    
    private func setColor(records: [RecordClass], _ segment: RecordType) {
        var color: UIColor?

        if segment == .expense || segment == .income {
            // Цвет берется из категории в операции
            guard let categoryID = records.first?.categoryID else { return }

            let parentalCategoryID: ObjectId
            if let subcategory = Categories.shared.getSubcategory(for: categoryID) {
                parentalCategoryID = subcategory.parentCategory
            } else {
                parentalCategoryID = categoryID
            }

            guard let category = Categories.shared.getCategory(for: parentalCategoryID),
                  let categoryColor = category.color else { return }

            color = UIColor(hex: categoryColor)
        } else {
            // Цвет берется по типу операции
            color = records.first?.type == RecordType.expense.rawValue ? UIColor(named: "expense") : UIColor(named: "income")
        }

        pieChartColors.append(color ?? .white)
    }
    
    // Устанавливаем словарь, который будем перебирать для получения цветов и суммы операций
    private func setDictionary(_ segment: RecordType, records: [RecordClass]) -> [String: [RecordClass]] {
        Dictionary(grouping: records, by: {
            let parentalCategoryID: ObjectId
            if let subcategory = Categories.shared.getSubcategory(for: $0.categoryID) {
                parentalCategoryID = subcategory.parentCategory
            } else {
                parentalCategoryID = $0.categoryID
            }
            
            guard let category = Categories.shared.getCategory(for: parentalCategoryID) else { return "" }
            
            let total = RecordType.allOperations.rawValue

            return segment.rawValue == total ? category.type ?? total : category.name
        })
    }
    
}
