//
//  HomeTVAddCell.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit


extension HomeVC {
    
    func sendNewOperation(id: Int?, amount: Double, description: String, category: String,
                          image: UIImage, date: Date, type: RecordType, color: UIColor) {
                
//        print("""
//        _______________________________
//
//        Category: \(category)
//        Amount: \(amount)
//        Description: \(description)
//        Date: \(date)
//        Image: \(image)
//        ID: \(id ?? 0)
//        Type: \(type)
//        _______________________________
//        """)
        
        // Редактирование ячейки по ее id
        if let oldCellId = id {
            // ix это индекс, который возвращается, если имеется совпадение
            if let ix = Records.shared.records[type]!.firstIndex(where: { searchedRecord in
                searchedRecord.id == oldCellId
            }) {
                // По индексу заменяются старые значения операции на новые
                Records.shared.records[type]![ix] = recordModel(id: oldCellId)
                
                guard type == segment else { return }
            } else {
                fatalError("couldn't edit old cell #\(oldCellId)")
            }
        } else { // Создается новая ячейка, ей дается уникальный id
            let operationID = Int.random(in: 0..<10000000) // исправить

            // Добавление в массив новой операции
            Records.shared.records[type]!.append(recordModel(id: operationID))
            Records.shared.records[.allOperations]!.append(recordModel(id: operationID))
            
            DispatchQueue.main.async { [self] in
                if !categoriesArr.contains(where: { $0.name == category }) {
                    categoriesArr.append(HomeCVCategory(name: category, color: color, type: type))
                }
            }
            
            guard type == segment else {
                if ((Records.shared.records[segment]?.isEmpty) != nil) {
                    typeSwitcher.selectedSegmentIndex = typeSwitcher.selectedSegmentIndex != 0 ? 0 : 1
                    
                    switchAction() // убрать
                }
                return
            }
        }
        
        func recordModel(id: Int) -> Record {
            return Record(
                amount: abs(amount),
                descriptionText: description,
                categoryText: category,
                categoryImage: image,
                date: date,
                id: id,
                type: type,
                categoryColor: color
            )
        }
    }
    
}
