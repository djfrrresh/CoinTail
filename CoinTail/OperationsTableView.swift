//
//  OperationsTableView.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy


extension HomeViewController: UITableViewDelegate, UITableViewDataSource, AddNewOpSendData {
    
    func setTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "HomeCustomCell")
        self.tableView.delegate = self // Реагирование на события
        self.tableView.dataSource = self // Здесь подаются данные
        
        self.tableView.easy.layout([
            Left(0),
            Right(0),
            Height(400),
            CenterX(0),
            Bottom(0)
        ])
    }
    
    func sendCategoryButtonText(categoryText: String) {
        print("Category: \(categoryText)")
        self.categoryText = categoryText
    }
    
    func sendAmount(amountText: String) {
        print("Amount: \(amountText)")
        self.amountText = amountText
    }
    
    func sendDescription(descriptionText: String) {
        print("Description: \(descriptionText)")
        self.descriptionText = descriptionText
    }
    
    func sendDate(dateText: String) {
        print("Date: \(dateText)")
        self.dateText = dateText
    }
    
    func sendCategoryImage(categoryImage: String) {
        print(categoryImage)
        self.categoryImage = categoryImage
    }
    
    // Добавление ячеек по 1 снизу
    func addRowToEnd() {
        self.cellArr.append("aaa") // Добавление в массив нового элемента
        self.tableView.insertRows(at: [IndexPath(row: self.cellArr.count - 1, section: 0)], with: .automatic) // + 1 элемент
    }
    
    // Задается количество ячеек
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    // Ячейки заполняются
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCustomCell", for: indexPath) as? CustomCell
        
        let image = UIImage(systemName: categoryImage)
        cell!.dateLabel.text = dateText
        cell!.amountLabel.text = ("Amount: \(amountText)")
        cell!.categoryLabel.text = categoryText
        cell!.descriptionLabel.text = descriptionText
        cell!.categoryImage.image = image
        
        return cell!
    }
    
    // Выводит нажатия на ячейки в консоль
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        print("Cell \(indexPath.row + 1) tapped")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
      }
    
    // Функция удаления и редактирования ячеек из таблицы
//    func tableView(_ tableView: UITableView,
//        editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        var num_in_cell = Float(self.cellArr[indexPath.row]) // Число в ячейке
//
//        // Редактирование ячейки
//        let editAction = UITableViewRowAction(style: .default,
//            title: "Edit",
//            handler: { (action, indexPath) in
//
//            // Окошко с редактированием, кнопки "Обновить" и "Отмена"
//            let alert = UIAlertController(title: "Edit list item", message: "", preferredStyle: .alert)
//
//            // Поле для редактирования текста
//            alert.addTextField(configurationHandler: { (textField) in
//                textField.text = self.cellArr[indexPath.row]
//            })
//
//            alert.addAction(UIAlertAction(title: "Update",
//                style: .default,
//                handler: { [self] (updateAction) in
//                self.cellArr[indexPath.row] = alert.textFields!.first!.text! // Обращение к текстовому полю во всплывающем окне и сохранение текста
//
//                var remainder = Float(cellArr[indexPath.row]) // Остаток
//                balanceScore = Float(round(100 * (balanceScore + remainder! - num_in_cell!))/100)
//                balance.text = "Your Balance: \(balanceScore)"
//
//                self.tableView.reloadRows(at: [indexPath], with: .fade)
//            }))
//
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            self.present(alert, animated: false) // Высвечивает окошко
//        })
//        editAction.backgroundColor = .systemGreen
//
//        // Удаление ячейки
//        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { [self] (action, indexPath) in
//
//            var num_in_cell = Float(self.cellArr[indexPath.row]) // Число в ячейке
//            self.balanceScore = Float(round(100 * (self.balanceScore - num_in_cell!))/100)
//            self.balance.text = "Your Balance: \(balanceScore)"
//
//            self.cellArr.remove(at: indexPath.row) // Удаление объекта из массива
//
//            tableView.reloadData() // Корректирует смещения в таблице, обновляет данные
//        })
//
//        return [deleteAction, editAction]
//    }
    
}
