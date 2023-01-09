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

    // Задается количество групп и ячеек по выбранному типу операций
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        Storage.shared.records[currentSegmentType]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfSections section: Int) -> Int {
        Storage.shared.records[currentSegmentType]?.count ?? 0
    }

    // Ячейки заполняются данными
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Уникальный идентификатор ячейки, принимает кастомную структуру
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCustomCell", for: indexPath) as? CustomCell
        
        let record = Storage.shared.records[currentSegmentType]![indexPath.row]
        let image = UIImage(systemName: record.categoryImage)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        cell!.amountLabel.text = ("\(record.amount)")
        cell!.categoryLabel.text = record.categoryText
        cell!.categoryImage.image = image
        
        return cell!
    }
    
    // При нажатии на ячейку происходит переход на экран с редактированием
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
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
    
    // Высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if (section == 0) {

            let view = UIView()
            let label = UILabel()
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            if ((Storage.shared.records[currentSegmentType]?.isEmpty) == false) {
                let date = dateFormatter.string(from: (Storage.shared.records[currentSegmentType]?[section].date)!)
                print(date)
                label.text = date
            }

            view.addSubview(label)

            label.translatesAutoresizingMaskIntoConstraints = false

            return view
        }
        
        if (section == 1) {

            let view = UIView()
            let label = UILabel()

            label.text = "My Details 2"

            view.addSubview(label)

            label.translatesAutoresizingMaskIntoConstraints = false

            return view
        }

        return nil
    }
    
    // Удаление ячейки
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [self] (_, _, completionHandler) in
            
            print("Deleted Value: \(Storage.shared.records[currentSegmentType]![indexPath.row].amount)")

            Storage.shared.records[currentSegmentType]!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
                        
            print("Balance: \(Storage.shared.balance(nil))")
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}
