//
//  AddOperationUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


extension AddOperationVC: SendCategoryID, AddOperationCellDelegate {
    
    func sendCategoryData(id: ObjectId) {
        guard let category = Categories.shared.getGeneralCategory(for: id) else { return }
        
        categoryID = id
        operationCategory = category.name
    }
    
    func cell(didUpdateOperationAmount amount: String?) {
        operationAmount = amount
    }
    
    func cell(didUpdateOperationDescription description: String?) {
        operationDescription = description ?? ""
    }
    
    func cell(didUpdateOperationDate date: Date) {
        operationDate = date
    }
    
    // Установка таргетов для кнопок
    func setTargets() {
        deleteOperationButton.addTarget(self, action: #selector(removeOperation), for: .touchUpInside)
        addOperationTypeSwitcher.addTarget(self, action: #selector(switchButtonAction), for: .valueChanged)
    }
    
    // Проверка поля Amount и текста из кнопки категории на наличие данных в них
    func recordValidation(amount: Double, categoryText: String, accountID: ObjectId?, completion: ((ObjectId) -> Void)? = nil) {
        let missingAmount = "\(amount)" == "" || amount == 0
        let missingCategory = categoryText == ""
        var account: AccountClass?
        if let accID = accountID {
            account = Accounts.shared.getAccount(for: accID)
        }

        if missingAmount {
            infoAlert("Missing value in amount field".localized())
        } else if missingCategory {
            infoAlert("No category selected".localized())
        } else if account != nil && account?.currency != "\(selectedCurrency)" {
            //TODO: premium
//            if AppSettings.shared.premium?.isPremiumActive ?? false {
                infoAlert("You cannot specify an account for this transaction with another currency".localized())
                
                return
//            }
        } else {
            guard let categoryID = self.categoryID,
                  let category = Categories.shared.getGeneralCategory(for: categoryID) else { return }

            completion?(category.id)
        }
    }
    
    // Повтор последней операции
    func repeatOperationAction() {
        confirmationAlert(
            title: "Repeat last operation".localized(),
            message: "Do you want to repeat the last operation?".localized(),
            confirmActionTitle: "Confirm".localized()
        ) { [weak self] in
            guard let strongSelf = self else { return }

            if let lastRecord = Records.shared.records.last {
                strongSelf.setFormWithRecord(lastRecord)
            }
        }
    }
    
    private func setFormWithRecord(_ record: RecordClass) {
        // Сумма
        operationAmount = "\(abs(record.amount))"
        let amountIndexPath = IndexPath(item: 0, section: 0)
        updateAmount(at: amountIndexPath, text: "\(abs(record.amount))")

        // Описание
        operationDescription = record.descriptionText
        let descriptionIndexPath = IndexPath(item: 0, section: 1)
        updateDescription(at: descriptionIndexPath, text: record.descriptionText)

        // Дата
        operationDate = record.date
        let dateIndexPath = IndexPath(item: 4, section: 0)
        let operationDF: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "dd/MM/yyyy"
            
            return formatter
        }()
        updateDate(at: dateIndexPath, text: operationDF.string(from: record.date))

        guard let recordType = RecordType(rawValue: record.type) else { return }
        // Тип операции
        addOperationSegment = recordType
        addOperationTypeSwitcher.selectedSegmentIndex = addOperationSegment == .income ? 0 : 1

        // Валюта
        selectedCurrency = record.currency

        // Категория
        if let category = Categories.shared.getCategory(for: record.categoryID) {
            operationCategory = category.name
            categoryID = record.categoryID
        }

        // Счет
        if let accountID = record.accountID, let account = Accounts.shared.getAccount(for: accountID) {
            selectedAccount = account.name
            self.accountID = accountID
        }        
    }
    
}
