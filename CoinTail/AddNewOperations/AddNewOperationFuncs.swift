//
//  AddNewOperationStacksFunc.swift
//  CoinTail
//
//  Created by Eugene on 25.10.22.
//

import UIKit
import EasyPeasy


extension AddNewOperationVC {
    
    // Создание стака между двумя элементами
    func setUniqueStack (stack: UIStackView, view_1: UIView, view_2: UIView?) {
        stack.axis = .vertical
        stack.spacing = 6
        stack.addArrangedSubview(view_1)
        stack.addArrangedSubview(view_2!)
    }
    
    // Создание вертикального меню выше пикера времени с кнопками действия
    func createToolbar() -> UIToolbar { // Всплывающий снизу DatePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolbar.setItems([doneButton], animated: true)

        return toolbar
    }
    
    // Проверка поля Amount и текста из кнопки категории на наличие данных в них
    func checkAmountCategory(amount: Float, categoryText: String) {
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in } )

        if (abs(amount) == 0.0 && categoryText == "Select category") {
            let alert = checkValues("Error", "Missing value in amount field and no category selected")
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else if (abs(amount) == 0.0) {
            let alert = checkValues("Error", "Missing value in amount field")
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else if (categoryText == "Select category") {
            let alert = checkValues("Error", "No category selected")
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        // Отправка данных в HomeViewController
        else {
            // Удаление текста Today
            var dateText = self.dateTextField.text!
            if (dateText.contains("Today")) {
                dateText = dateText.replacingOccurrences(of: "Today, ", with: "")
            }
            
            guard let segment = switchButton.titleForSegment(at: switchButton.selectedSegmentIndex) else { return }

            addNewOpDelegate?.sendNewOperation(id: operationID, amount: abs(amount), description: descriptionTextField.text!, category: categoryButton.titleLabel!.text!, image: categoryImage, date: datePicker.date, switcher: segment)
            
            self.navigationController?.popToRootViewController(animated: true) // Закрыть AddNewOperationVC
        }
    }
    
    // Всплывающий алерт при ошибке
    func checkValues(_ title: String, _ message: String) -> UIAlertController {
        let emptyValueMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return emptyValueMessage
    }
    
}
