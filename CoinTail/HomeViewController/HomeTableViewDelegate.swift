//
//  HomeTableViewDelegate.swift
//  CoinTail
//
//  Created by Eugene on 06.12.22.
//

import UIKit


extension HomeViewController: AddNewOpSendData {
    
    func sendNewOperation(id: Int?, amount: Double, description: String, category: String,
                          image: String, date: Date, switcher: String, type: RecordType) {
        var amount = amount
        if type == .expense && amount > 0 {
            amount *= -1
        }
        print("Category: \(category)")
        print("Amount: \(amount)")
        print("Description: \(description)")
        print("Date: \(date)")
        print("Image: \(image)")
        print("Switcher: \(switcher)")
        print("ID: \(id ?? 0)")
        print("Type: \(type)")
        // аналогично if id != nil, тут мы распаковываем значение
        if let oldCellId = id {
            // ix это индекс, который возвращается, если имеется совпадение. Вместо $0 стоят searchedRecord
            if let ix = Storage.shared.records[type]!.firstIndex(where: { searchedRecord in
                searchedRecord.id == oldCellId
            }) { // По индексу заменяются старые значения на новые
                Storage.shared.records[type]![ix] = Record(amount: amount, descriptionText: description, categoryText: category, categoryImage: image, date: date, id: oldCellId, type: type)
                guard type == currentSegmentType else {
                    return
                }
                self.tableView.reloadRows(at: [IndexPath(row: ix, section: 0)], with: .automatic)
            } else {
                fatalError("couldn't edit old cell #\(oldCellId)")
            }
        } else { // Создается новая ячейка
            let operationID = Int.random(in: 0...10000)
            Storage.shared.records[type]!.append(Record(amount: amount, descriptionText: description, categoryText: category, categoryImage: image, date: date, id: operationID, type: type)) // Добавление в массив нового элемента
            guard type == currentSegmentType else {
                if Storage.shared.records[currentSegmentType]!.isEmpty {
                    switchButton.selectedSegmentIndex = switchButton.selectedSegmentIndex != 0 ? 0 : 1
                    switchButtonAction(target: switchButton)
                }
                return
            }
            self.tableView.insertRows(at: [IndexPath(row: Storage.shared.records[type]!.count - 1, section: 0)], with: .automatic)
        }
    }
    
}
