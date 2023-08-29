//
//  AddOperationActions.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension AddOperationVC {
    
    // Кнопка done в ToolBar'е для dateTF
    @objc func doneButtonAction() {        
        let date = AddOperationVC.datePicker.date
        let formatter = AddOperationVC.dateFormatter
        
        // Проверка на сегодняшнюю дату
        if formatter.string(from: date) == formatter.string(from: (Date())) {
            dateTF.text = "\(AddOperationVC.todayText) \(formatter.string(from: date))"
        } else {
            // Ставим выбранную дату из пикера
            dateTF.text = formatter.string(from: date)
        }
        
        self.view.endEditing(true)
    }
    
    // Сохранение операции
    @objc func saveButtonAction(sender: AnyObject) {
        let amount = Double(amountTF.text ?? "") ?? 0
        
        let categoryText = categoryButton.titleLabel?.text ?? "category"

        recordValidation(amount: amount, categoryText: categoryText) { [weak self] amount, category in
            guard let strongSelf = self else { return }
            var dateText = strongSelf.dateTF.text!
            
            if (dateText.contains(AddOperationVC.todayText)) {
                // Удаление "Today" с DateTF
                dateText = dateText.replacingOccurrences(of: "\(AddOperationVC.todayText), ", with: "")
            }
            
            let date = AddOperationVC.dateFormatter.date(from: dateText) ?? Date()
            let desctiption = strongSelf.descriptionTF.text ?? ""
                        
            Records.shared.recordID += 1

            let record = Record(
                amount: amount,
                descriptionText: desctiption,
                date: date,
                id: Records.shared.recordID,
                type: strongSelf.addOperationSegment,
                category: category
            )
            
            strongSelf.saveOperationButton.removeTarget(nil, action: nil, for: .allEvents)
            strongSelf.categoryButton.removeTarget(nil, action: nil, for: .allEvents)
                        
            if let operationID = strongSelf.operationID {
                Records.shared.editRecord(for: operationID, replacingRecord: record)
            } else {
                Records.shared.addRecord(record: record)
            }
            
            strongSelf.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // Переключение типа операции
    @objc func switchButtonAction(target: UISegmentedControl) {
        categoryButton.setTitle(AddOperationVC.defaultCategory, for: .normal)
        
        let segment = addOperationTypeSwitcher.titleForSegment(at: addOperationTypeSwitcher.selectedSegmentIndex)
        
        addOperationSegment = RecordType(rawValue: segment ?? "") ?? .income
        
        // Добавление неудаляемого знака минуса в тип "траты"
        if addOperationSegment == .expense {
            if !amountTF.text!.hasPrefix("-") {
                amountTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: amountTF.frame.height))
                amountTF.leftViewMode = .always
                amountTF.text = "-" + (amountTF.text ?? "0.00")
            }
        } else { // Удаление минуса
            amountTF.text = amountTF.text?.replacingOccurrences(
                of: "-",
                with: ""
            )
        }
    }
    
    // Повтор последней операции
    @objc func repeatOperationAction() {
        let confirmAction = UIAlertAction(title: "Confirm".localized(), style: .default) { [weak self] _ in
            guard let strongSelf = self,
                  let id = Records.shared.total.last?.id,
                  let record = Records.shared.getRecord(for: id) else { return }

            strongSelf.addOperationTypeSwitcher.isHidden = true
            strongSelf.category = record.category
            strongSelf.amountTF.text = "\(record.amount)"
            strongSelf.descriptionTF.text = record.descriptionText
            strongSelf.categoryButton.setTitle(record.category.name, for: .normal)
            strongSelf.dateTF.text = Self.dateFormatter.string(from: record.date)
            strongSelf.addOperationSegment = record.type
            strongSelf.addOperationTypeSwitcher.selectedSegmentIndex = strongSelf.addOperationSegment == .income ? 0 : 1
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        let alertView = UIAlertController(title: "Repeat last operation".localized(), message: "Do you want to repeat the last operation?".localized(), preferredStyle: .alert)
        
        alertView.addAction(confirmAction)
        alertView.addAction(cancelAction)

        self.present(alertView, animated: true)
    }
    
    // Переход на экран с выбором категории
    @objc func categoryButtonAction() {
        saveOperationButton.removeTarget(nil, action: nil, for: .allEvents)
        categoryButton.removeTarget(nil, action: nil, for: .allEvents)
        
        // TODO: возможно нужно поменять "Income" на localized
        // Передаем название и иконки категорий по типу операций
        let vc = SelectCategoryVC(segmentTitle: addOperationTypeSwitcher.titleForSegment(at: addOperationTypeSwitcher.selectedSegmentIndex) ?? "Income")

        vc.categoryDelegate = self
        
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Удаление выбранной операции по ее ID
    @objc func removeOperation() {
        guard let id = operationID else { return }
        
        let confirmAction = UIAlertAction(title: "Confirm".localized(), style: .default) { [weak self] _ in
            Records.shared.deleteRecord(for: id)
            self?.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        let alertView = UIAlertController(title: "Delete operation".localized(), message: "Are you sure?".localized(), preferredStyle: .alert)
        
        alertView.addAction(confirmAction)
        alertView.addAction(cancelAction)

        self.present(alertView, animated: true)
    }
}
