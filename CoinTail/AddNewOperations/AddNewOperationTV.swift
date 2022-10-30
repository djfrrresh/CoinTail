//
//  AddNewOperationTV.swift
//  CoinTail
//
//  Created by Eugene on 27.10.22.
//

import UIKit
import EasyPeasy


extension AddNewOperationPopVC: UITableViewDelegate, UITableViewDataSource {
    
    // Задается количество ячеек
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    // Ячейки заполняются
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(self.categories[indexPath.row])"
//        cell.categoryDelegate = self
        return cell
    }
    
    // Выводит нажатия на ячейки
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
                
        categoryDelegate?.sendCategory(category: self.categories[indexPath.row]) // Передаем выбранную категорию
                        
        self.dismiss(animated: true, completion: nil) // Закрываем PopVC
    }
    
}

// Протокол с функциями, по которому передаем данные из 1 контроллера в другой
protocol СategorySendText: AnyObject {
    func sendCategory(category: String)
}
