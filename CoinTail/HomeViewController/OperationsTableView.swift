//
//  OperationsTableView.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy
import Charts


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    // Задается количество ячеек
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        Storage.shared.records[currentSegmentType]?.count ?? 0
    }

    // Ячейки заполняются
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCustomCell", for: indexPath) as? CustomCell
        
        let record = Storage.shared.records[currentSegmentType]![indexPath.row]
        let image = UIImage(systemName: record.categoryImage)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        cell!.dateLabel.text = dateFormatter.string(from: record.date)
        cell!.amountLabel.text = ("Amount: \(record.amount)")
        cell!.categoryLabel.text = record.categoryText
        cell!.descriptionLabel.text = record.descriptionText
        cell!.categoryImage.image = image

        return cell!
    }
    
    // Выводит нажатия на ячейки в консоль
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        print("Selected Id: \(Storage.shared.records[currentSegmentType]![indexPath.row].id)")     
    }
    
    // Высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    // Удаление и редактирование ячейки
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Удаление ячейки
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [self] (_, _, completionHandler) in
            
            print("Deleted Value: \(Storage.shared.records[currentSegmentType]![indexPath.row].amount)")

            Storage.shared.records[currentSegmentType]!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
                        
            print("Balance: \(Storage.shared.balance(nil))")
            
            self.setChart() // Обновление диаграммы после удаления ячейки
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        // Переход в AddNewOperationVC для редактирования
        let editAction = UIContextualAction(style: .normal, title: nil) { [self] (_, _, completionHandler) in
            let index = Storage.shared.records[currentSegmentType]![indexPath.row]
            let editCellInfo = AddNewOperationVC(homeViewController: self, operationID: index.id, segmentIndex: switchButton.selectedSegmentIndex)
                                    
            editCellInfo.amountTextField.text = String(index.amount)
            editCellInfo.descriptionTextField.text = String(index.descriptionText)
            editCellInfo.categoryButton.setTitle(index.categoryText, for: .normal)
            editCellInfo.saveButton.setTitle("Edit operation", for: .normal)
            editCellInfo.sendCategoryImage(categoryImage: index.categoryImage)

            // Проверка сегодняшней даты
            self.checkToDay(date: index.date, textField: editCellInfo.dateTextField)
            
            // Сохраняет выбранный тип операции
            switch currentSegmentType {
            case .expense:
                editCellInfo.switchButton.selectedSegmentIndex = 1
            case .income:
                editCellInfo.switchButton.selectedSegmentIndex = 0
            }
            
            editCellInfo.navigationItem.title = "Editing cell"
            editCellInfo.addNewOpDelegate = self // Связь с контроллером, откуда передаются данные
            self.navigationController?.pushViewController(editCellInfo, animated: true)
        }
        
        editAction.image = UIImage(systemName: "square.and.pencil")
        editAction.backgroundColor = .systemBlue

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    
}
