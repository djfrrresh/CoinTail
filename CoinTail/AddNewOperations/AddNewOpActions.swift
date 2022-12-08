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
        let toDay = Date()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        // Для кнопки с датой
//        self.dateButton.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
        
        // Проверка на сегодняшнюю дату
        print(dateFormatter.string(from: (datePicker.date)))
        if (dateFormatter.string(from: (datePicker.date)) == dateFormatter.string(from: (toDay))) {
            self.dateTextField.text = "Today \(dateFormatter.string(from: datePicker.date))"
        } else {
            // Ставим выбранную дату из пикера
            self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
    }
    
    @objc func saveButtonAction(sender: AnyObject) {
        guard let amount = Float(amountTextField.text!) else { fatalError("invalid amount \(String(describing: amountTextField.text))")}
        let categoryText = categoryButton.titleLabel!.text!

        // Проверка поля Amount и текста из кнопки категории на наличие данных в них
        checkAmountCategory(amount: amount, categoryText: categoryText)
    }
    
    @objc func categoryButtonAction() {
        // Заполнить следующий контроллер категориями в зависимости от выбранного типа операции
        guard let segment = switchButton.titleForSegment(at: switchButton.selectedSegmentIndex) else { return }
     
        switch segment {
            case "Expense":
                categories = self.expenseCategories
                categoryImages = self.expenseImages
                break
            case "Income":
                categories = self.incomeCategories
                categoryImages = self.incomeImages
                break
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
        
        switch segmentTitle {
            case "Expense":
            let amount = Float(amountTextField.text!)
                self.amountTextField.text = String(-(amount ?? -0.0))
                self.categoryButton.setTitle("Select category", for: .normal)
            break
            case "Income":
            let amount = Float(amountTextField.text!)
                self.amountTextField.text = String(abs(amount  ?? 0.0));
                self.categoryButton.setTitle("Select category", for: .normal)
            break
            default:
                fatalError("undefined segment")
        }
    }
}
