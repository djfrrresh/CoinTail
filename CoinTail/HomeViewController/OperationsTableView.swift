//
//  OperationsTableView.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy


extension HomeViewController: UITableViewDelegate, UITableViewDataSource, AddNewOpSendData {
    func sendNewOperation(amount: Float, description: String, category: String,
                          image: String, date: Date, switcher: String) {
        print("Category: \(category)")        
        print("Amount: \(amount)")
        print("Description: \(description)")
        print("Date: \(date)")
        print("Image: \(image)")
        print("Switcher: \(switcher)")
        
        if (switcher == "Income") {
            balanceStruct.balanceScore += amount
            balanceStruct.incomeBalanceScore += amount
        } else if (switcher == "Expense") {
            balanceStruct.balanceScore -= amount
            balanceStruct.expenseBalanceScore += amount
        }
                
        self.cellArr.append(Record(amount: amount, descriptionText: description, categoryText: category, categoryImage: image, date: date)) // Добавление в массив нового элемента
        self.tableView.insertRows(at: [IndexPath(row: self.cellArr.count - 1, section: 0)], with: .automatic) // + 1 элемент
    }
    
    
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

    // Задается количество ячеек
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }

    // Ячейки заполняются
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCustomCell", for: indexPath) as? CustomCell
        
        let record = cellArr[indexPath.row]
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
        print("Cell \(indexPath.row + 1) tapped")
        
        print("Selected Value: \(cellArr[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Удаление ячейки
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            
            print("Deleted Value: \(self.cellArr[indexPath.row].amount)")
            
            // Не обновляется общий баланс
            self.balanceStruct.balanceScore -= self.cellArr[indexPath.row].amount

            self.cellArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
                        
            print("Balance: \(self.balanceStruct.balanceScore)")
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        let editAction = UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in

            let editCellInfo = AddNewOperationVC(homeViewController: self)
            let index = self.cellArr[indexPath.row]
            editCellInfo.descriptionTextField.text = String(index.amount)
            let navController = UINavigationController(rootViewController: editCellInfo)
            editCellInfo.navigationItem.title = "Editing cell"
            self.present(navController, animated: true, completion: nil)
        }
        
        editAction.image = UIImage(systemName: "square.and.pencil")
        editAction.backgroundColor = .systemBlue

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    
}
