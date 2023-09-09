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
        let date = AddOperationVC.operationDatePicker.date
        let formatter = AddOperationVC.operationDF
        let dateString = formatter.string(from: date)
        
        // Ставим выбранную дату из пикера или сегодняшнюю с припиской Today
        dateTF.text = dateString == formatter.string(from: Date()) ? "\(AddOperationVC.todayText) \(dateString)" : dateString
        
        self.view.endEditing(true)
    }
    
    // Сохранение операции
    @objc func saveButtonAction(sender: AnyObject) {
        let amount = Double(amountTF.text ?? "") ?? 0
        guard let categoryText = categoryButton.titleLabel?.text,
              let accountText = accountButton.titleLabel?.text else { return }

        recordValidation(amount: amount, categoryText: categoryText, accountText: accountText) { [weak self] amount, category in
            guard let strongSelf = self else { return }
            guard let dateTFText = strongSelf.dateTF.text else { return }
            
            let dateString = strongSelf.deleteTodayFromDateTF(dateTFText)
            let date = AddOperationVC.operationDF.date(from: dateString) ?? Date()
            let desctiption = strongSelf.descriptionTF.text ?? ""
            let account = strongSelf.account ?? nil
            
            Records.shared.recordID += 1

            let record = Record(
                amount: amount,
                descriptionText: desctiption,
                date: date,
                id: Records.shared.recordID,
                type: strongSelf.addOperationSegment,
                category: category,
                account: account
            )
                        
            strongSelf.saveOperationButton.removeTarget(nil, action: nil, for: .allEvents)
            strongSelf.categoryButton.removeTarget(nil, action: nil, for: .allEvents)
            strongSelf.accountButton.removeTarget(nil, action: nil, for: .allEvents)
                        
            if let operationID = strongSelf.operationID {
                Records.shared.editRecord(for: operationID, replacingRecord: record)
            } else {
                Records.shared.addRecord(record: record)
            }
            
            strongSelf.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // Удаление "Today" с DateTF
    private func deleteTodayFromDateTF(_ text: String) -> String {
        if (text.contains(AddOperationVC.todayText)) {
            return text.replacingOccurrences(of: "\(AddOperationVC.todayText), ", with: "")
        }
        
        return text
    }
    
    // Переключение типа операции
    @objc func switchButtonAction(target: UISegmentedControl) {
        // Сбрасываем выбранную категорию на значение по умолчанию
        categoryButton.setTitle(AddOperationVC.defaultCategory, for: .normal)
        
        let segment = addOperationTypeSwitcher.titleForSegment(at: addOperationTypeSwitcher.selectedSegmentIndex)
        
        addOperationSegment = RecordType(rawValue: segment ?? "") ?? .income
        
        // Добавляем или удаляем знак минуса в зависимости от типа операции
        if addOperationSegment == .expense {
            addMinusIfNeeded()
        } else {
            removeMinusIfNeeded()
        }
    }
    
    // Добавление знака минуса
    private func addMinusIfNeeded() {
        guard !amountTF.text!.hasPrefix("-") else {
            return
        }

        amountTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: amountTF.frame.height))
        amountTF.leftViewMode = .always
        amountTF.text = "-" + (amountTF.text ?? "0.00")
    }

    // Удаление минуса
    private func removeMinusIfNeeded() {
        // Удаляем знак минуса, если он есть
        amountTF.text = amountTF.text?.replacingOccurrences(of: "-", with: "")
    }
    
    // Повтор последней операции
    @objc func repeatOperationAction() {
        let alertView = UIAlertController(
            title: "Repeat last operation".localized(),
            message: "Do you want to repeat the last operation?".localized(),
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "Confirm".localized(), style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            
            if let lastRecord = Records.shared.total.last {
                strongSelf.addOperationTypeSwitcher.isHidden = true
    
                strongSelf.setFormWithRecord(lastRecord)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        alertView.addAction(confirmAction)
        alertView.addAction(cancelAction)

        self.present(alertView, animated: true)
    }
    
    private func setFormWithRecord(_ record: Record) {
        category = record.category
        amountTF.text = "\(record.amount)"
        descriptionTF.text = record.descriptionText
        categoryButton.setTitle(record.category.name, for: .normal)
        dateTF.text = Self.operationDF.string(from: record.date)
        addOperationSegment = record.type
        addOperationTypeSwitcher.selectedSegmentIndex = addOperationSegment == .income ? 0 : 1
        if let accountName = Accounts.shared.getAccount(for: record.account?.name ?? AddOperationVC.defaultAccount)?.name {
            accountButton.setTitle(accountName, for: .normal)
        }
    }
    
    // Переход на экран с выбором категории
    @objc func goToSelectCategoryVC() {
        saveOperationButton.removeTarget(nil, action: nil, for: .allEvents)
        categoryButton.removeTarget(nil, action: nil, for: .allEvents)
        
        // Передаем название и иконки категорий по типу операций
        let vc = SelectCategoryVC(segmentTitle: addOperationTypeSwitcher.titleForSegment(at: addOperationTypeSwitcher.selectedSegmentIndex) ?? "Income")
        vc.categoryDelegate = self
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Удаление выбранной операции по ее ID
    @objc func removeOperation() {
        guard let id = operationID else { return }
        
        let alertView = UIAlertController(
            title: "Delete operation".localized(),
            message: "Are you sure?".localized(),
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "Confirm".localized(), style: .default) { [weak self] _ in
            Records.shared.deleteRecord(for: id)
            self?.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        alertView.addAction(confirmAction)
        alertView.addAction(cancelAction)

        self.present(alertView, animated: true)
    }
    
    @objc func goToAccountsVC() {
        saveOperationButton.removeTarget(nil, action: nil, for: .allEvents)
        categoryButton.removeTarget(nil, action: nil, for: .allEvents)
        accountButton.removeTarget(nil, action: nil, for: .allEvents)
        
        let vc = AccountsVC(isSelected: true)
        vc.accountDelegate = self
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
