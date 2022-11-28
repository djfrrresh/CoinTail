//
//  AddNewOperationActions.swift
//  CoinTail
//
//  Created by Eugene on 27.10.22.
//

import UIKit


extension AddNewOperationVC {
    
    // Для кнопки с датой
//    @objc func createToolbarAction() -> UIToolbar { // Всплывающий снизу DatePicker
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
//        toolbar.setItems([doneButton], animated: true)
//
//        return toolbar
//    }
    
    @objc func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        // Для кнопки с датой
//        self.dateButton.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
        
        // Ставим выбранную дату из пикера
        self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func saveButtonAction(sender: AnyObject) {
        guard let amount = Float(amountTextField.text!) else { fatalError("invalid amount \(String(describing: amountTextField.text))")}
        let categoryText = categoryButton.titleLabel!.text!
        
        // Проверка поля Amount и текста из кнопки категории на наличие данных в них
        func checkValues(_ title: String, _ message: String) -> UIAlertController {
            let emptyValueMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
            return emptyValueMessage
        }
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in } )
        
        if amount == 0.00 && categoryText == "Select category" {
            let alert = checkValues("Error", "Missing value in amount field and no category selected")
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else if (amount == 0.00) {
            let alert = checkValues("Error", "Missing value in amount field")
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else if (categoryText == "Select category") {
            let alert = checkValues("Error", "No category selected")
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else { // Отправка данных в HomeViewController
            var dateText = self.dateTextField.text!
            if (dateText.contains("Today")) {
                dateText = dateText.replacingOccurrences(of: "Today, ", with: "")
            }
            
            guard let segment = switchButton.titleForSegment(at: switchButton.selectedSegmentIndex) else { return }
            
            addNewOpDelegate?.sendNewOperation(amount: amount, description: descriptionTextField.text!, category: categoryButton.titleLabel!.text!, image: categoryImage, date: datePicker.date, switcher: segment)
            // Если написать HomeViewController().addRowToEnd(), то я создам новый объект
            // Теперь я обращаюсь к старому объекту (функции)
            
            self.navigationController?.popToRootViewController(animated: true) // Закрыть AddNewOperationVC
        }
    }
    
    @objc func categoryButtonAction() {
        
        // Заполнить следующий контроллер категориями в зависимости от выбранного типа операции
        guard let segment = switchButton.titleForSegment(at: switchButton.selectedSegmentIndex) else { return }
     
        switch segment {
            case "Expense":
                categories = self.expenseCategories
                categoryImages = self.expenseImages
            case "Income":
                categories = self.incomeCategories
                categoryImages = self.incomeImages
            default:
                fatalError("undefined segment")
        }
                    
        let vc = AddNewOperationPopVC(self.categories, self.categoryImages) // Передаем название и иконки
        vc.categoryDelegate = self // Связь с контроллером, откуда передаются данные
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        navigationController?.pushViewController(vc, animated: true) // Перейти в контроллер
    }
    
    @objc func switchButtonAction(target: UISegmentedControl) {
        let segmentTitle = target.titleForSegment(at: target.selectedSegmentIndex)!
        print("changed segment => \(segmentTitle)")
        
        switch segmentTitle {
            case "Expense":
                self.amountTextField.text = "-0.00"
            break
            case "Income":
                self.amountTextField.text = "0.00"
            break
            default:
                fatalError("undefined segment")
        }
    }
}
