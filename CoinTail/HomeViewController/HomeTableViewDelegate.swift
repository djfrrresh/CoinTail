//
//  HomeTableViewDelegate.swift
//  CoinTail
//
//  Created by Eugene on 06.12.22.
//

import UIKit


extension HomeViewController: AddNewOpSendData {
    
    func sendNewOperation(id: Int?, amount: Float, description: String, category: String,
                          image: String, date: Date, switcher: String) {
        print("Category: \(category)")
        print("Amount: \(amount)")
        print("Description: \(description)")
        print("Date: \(date)")
        print("Image: \(image)")
        print("Switcher: \(switcher)")
        print("ID: \(id ?? 0)")
        
        if (switcher == "Income") {
            balanceStruct.balanceScore += amount
            balanceStruct.incomeBalanceScore += amount
        } else if (switcher == "Expense") {
            balanceStruct.balanceScore -= amount
            balanceStruct.expenseBalanceScore += amount
        }
        
        // аналогично if id != nil, тут мы распаковываем значение
        if let oldCellId = id {
            // ix это индекс, который возвращается, если имеется совпадение. Вместо $0 стоят searchedRecord
            if let ix = self.cellArr.firstIndex(where: { searchedRecord in
                searchedRecord.id == oldCellId
            }) { // По индексу заменяются старые значения на новые
                self.cellArr[ix] = Record(amount: amount, descriptionText: description, categoryText: category, categoryImage: image, date: date, id: oldCellId)
                self.tableView.reloadRows(at: [IndexPath(row: ix, section: 0)], with: .automatic)
            } else {
                fatalError("couldn't edit old cell #\(oldCellId)")
            } // Создается новая ячейка
        } else {
            let operationID = Int.random(in: 0...10000)
            print("id: \(operationID)")
            self.cellArr.append(Record(amount: amount, descriptionText: description, categoryText: category, categoryImage: image, date: date, id: operationID)) // Добавление в массив нового элемента
            self.tableView.insertRows(at: [IndexPath(row: self.cellArr.count - 1, section: 0)], with: .automatic)
        }
    }
    
}
