//
//  AddOperationActions.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension AddOperationVC {
    
    // Кнопка done в dateTF
    @objc func doneButtonAction() {        
        let date = AddOperationVC.datePicker.date
        let formatter = AddOperationVC.dateFormatter
        
        // Проверка на сегодняшнюю дату
        if formatter.string(from: date) == formatter.string(from: (Date())) {
            dateTextField.text = "Today \(formatter.string(from: date))"
        } else {
            // Ставим выбранную дату из пикера
            dateTextField.text = formatter.string(from: date)
        }
        
        self.view.endEditing(true)
    }
    
    // Сохранение операции
    @objc func saveButtonAction(sender: AnyObject) {
        let amount = Double(amountTextField.text ?? "") ?? 0
        
        let categoryText = categoryButton.titleLabel?.text ?? "category"

        // Проверка поля Amount и текста из кнопки категории на наличие данных в них
        recordValidation(amount: amount, categoryText: categoryText) { [weak self] amount, category in
            guard let strongSelf = self else { return }
            var dateText = strongSelf.dateTextField.text!
            if (dateText.contains("Today")) {
                // Удаление "Today" с DateTF
                dateText = dateText.replacingOccurrences(of: "Today, ", with: "")
            }
            
            let date = AddOperationVC.dateFormatter.date(from: dateText) ?? Date()
            let desctiption = strongSelf.descriptionTextField.text ?? ""
            
            strongSelf.recordID += 1
            
            let record = Record(
                amount: amount,
                descriptionText: desctiption,
                date: date,
                id: strongSelf.recordID,
                type: strongSelf.addOperationSegment,
                category: category
            )
            
            if let operationID = strongSelf.operationID {
                Records.shared.editRecord(for: operationID, replacingRecord: record)
            } else {
                Records.shared.addNewOperation(record: record)
            }
            strongSelf.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // Переключение типа операции
    @objc func switchButtonAction(target: UISegmentedControl) {
        categoryButton.setTitle(AddOperationVC.defaultCategory, for: .normal)
        
        let segment = target.titleForSegment(at: target.selectedSegmentIndex)
        
        addOperationSegment = RecordType(rawValue: segment ?? "") ?? .income
        
        // Добавление неудаляемого знака минуса в тип "траты"
        if addOperationSegment == .expense {
            if !amountTextField.text!.hasPrefix("-") {
                
                amountTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: amountTextField.frame.height))
                amountTextField.leftViewMode = .always
                amountTextField.text = "-" + amountTextField.text!
                
            }
        } else { // Удаление минуса
            amountTextField.text = amountTextField.text?.replacingOccurrences(
                of: "-",
                with: ""
            )
        }
    }
    
    @objc func categoryButtonAction() {
        // Передаем название и иконки категорий по типу операций
        let vc = SelectCategoryVC(segmentTitle: addOperationTypeSwitcher.titleForSegment(at: addOperationTypeSwitcher.selectedSegmentIndex) ?? "Income")

        vc.categoryDelegate = self
        
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
