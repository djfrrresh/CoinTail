//
//  AddOperationActions.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy
import RealmSwift


extension AddOperationVC {
    
    // Сохранение операции
    @objc func saveButtonAction(sender: AnyObject) {
        let amount = Double(operationAmount ?? "0") ?? 0
        let categoryText = operationCategory ?? ""
        let desctiption = operationDescription
        var accountID: ObjectId?
        if self.accountID != nil {
            accountID = self.accountID
        }

        recordValidation(amount: amount, categoryText: categoryText, accountID: accountID) { [weak self] categoryID in
            guard let strongSelf = self else { return }

            let record = RecordClass()
            record.amount = amount
            record.descriptionText = desctiption ?? ""
            record.date = strongSelf.operationDate ?? Date()
            record.type = strongSelf.addOperationSegment.rawValue
            record.categoryID = categoryID
            record.currency = "\(strongSelf.selectedCurrency)"
            record.accountID = accountID

            if let recordID = strongSelf.recordID {
                record.id = recordID
                Records.shared.editRecord(replacingRecord: record)
            } else {
                Records.shared.addRecord(record: record)
            }

            strongSelf.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // Переключение типа операции
    @objc func switchButtonAction(target: UISegmentedControl) {
        // Сбрасываем выбранную категорию
        operationCategory = ""
        
        guard let segment = addOperationTypeSwitcher.titleForSegment(at: addOperationTypeSwitcher.selectedSegmentIndex) else { return }
        
        addOperationSegment = RecordType(rawValue: segment) ?? .income
    }
    
    // Повтор последней операции
//    @objc func repeatOperationAction() {
//        confirmationAlert(
//            title: "Repeat last operation".localized(),
//            message: "Do you want to repeat the last operation?".localized(),
//            confirmActionTitle: "Confirm".localized()
//        ) { [weak self] in
//            guard let strongSelf = self else { return }
//
//            if let lastRecord = Records.shared.records.last {
//                strongSelf.addOperationTypeSwitcher.isHidden = true
//
//                strongSelf.setFormWithRecord(lastRecord)
//            }
//        }
//    }
    
//    private func setFormWithRecord(_ record: RecordClass) {
        // Сумма
//        amountTF.text = "\(record.amount)"
//
//        // Описание
//        descriptionTF.text = record.descriptionText
//
//        // Дата
//        dateTF.text = Self.operationDF.string(from: record.date)
//
//        guard let recordType = RecordType(rawValue: record.type) else { return }
//        // Тип операции
//        addOperationSegment = recordType
//        addOperationTypeSwitcher.selectedSegmentIndex = addOperationSegment == .income ? 0 : 1
//
//        // Валюта
//        currencyButton.setTitle("\(record.currency)", for: .normal)
//
//        // Категория
//        if let category = Categories.shared.getCategory(for: record.categoryID) {
//            categoryButton.setTitle(category.name, for: .normal)
//        }
//
//        // Счет
//        if let accountID = record.accountID, let account = Accounts.shared.getAccount(for: accountID) {
//            accountButton.setTitle(account.name, for: .normal)
//        }
//    }
    
    // Переход на экран с выбором категории
    @objc func goToSelectCategoryVC() {
        let segmentTitle = addOperationTypeSwitcher.titleForSegment(at: addOperationTypeSwitcher.selectedSegmentIndex) ?? "Income"
        
        let vc = SelectCategoryVC(segmentTitle: segmentTitle, isParental: true, categoryID: nil)
        vc.categoryDelegate = self
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Удаление выбранной операции по ее ID
    @objc func removeOperation() {
        guard let id = recordID else { return }
        
        confirmationAlert(
            title: "Delete operation".localized(),
            message: "Are you sure?".localized(),
            confirmActionTitle: "Confirm".localized()
        ) { [weak self] in
            Records.shared.deleteRecord(for: id)
            
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // Закрытие пикера
    @objc func doneButtonAction() {
        toolBar.isHidden = true
        addOperationPickerView.isHidden = true
        addOperationPickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
}
