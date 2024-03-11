//
//  AddOperationUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import RealmSwift


extension AddOperationVC: SendCategoryID, SendAccount, AddOperationCellDelegate {
    
    func sendAccountData(id: ObjectId) {
        guard let account = Accounts.shared.getAccount(for: id) else {
            SentryManager.shared.capture(error: "No account to get", level: .error)
            
            return
        }
        
        accountID = id
        selectedAccount = account.name
    }
    
    func sendCategoryData(id: ObjectId) {
        guard let category = Categories.shared.getGeneralCategory(for: id) else {
            SentryManager.shared.capture(error: "No general category to get", level: .error)
            
            return
        }
        
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
            if !AppSettings.shared.premiumStatus.isPremiumActive {
                let vc = PremiumAlert(description: "You can specify an account for this transaction in another currency only with a premium subscription".localized())
                present(vc, animated: true, completion: nil)
                
                return
            }
        } else {
            guard let categoryID = self.categoryID,
                  let category = Categories.shared.getGeneralCategory(for: categoryID) else {
                SentryManager.shared.capture(error: "No category to get", level: .error)
                
                return
            }

            completion?(category.id)
        }
    }
    
    // Повтор последней операции
    func repeatOperationAction() {
        if let lastRecord = Records.shared.records.last {
            confirmationAlert(
                title: "Repeat last operation".localized(),
                message: "Do you want to repeat the last operation?".localized(),
                confirmActionTitle: "Confirm".localized()
            ) {
                self.setFormWithRecord(lastRecord)
            }
        } else {
            infoAlert("Create at least one operation so that it can be repeated".localized())
        }
    }
    
    // Заполнить поля данными из операции
    private func setFormWithRecord(_ record: RecordClass) {
        // Сумма
        operationAmount = "\(abs(record.amount))"
        let amountIndexPath = IndexPath(item: 0, section: 0)
        updateAmount(at: amountIndexPath, text: "\(abs(record.amount))")

        // Описание
        var text: String
        if record.descriptionText.isEmpty {
            text = defaultDescription
        } else {
            text = record.descriptionText
        }
        operationDescription = text
        let descriptionIndexPath = IndexPath(item: 0, section: 1)
        updateDescription(at: descriptionIndexPath, text: text)

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

        guard let recordType = RecordType(rawValue: record.type) else {
            SentryManager.shared.capture(error: "No RecordType to get", level: .error)
            
            return
        }
        // Тип операции
        addOperationSegment = recordType
        addOperationTypeSwitcher.selectedSegmentIndex = addOperationSegment == .expense ? 0 : 1

        // Валюта
        selectedCurrency = record.currency

        // Категория
        if let category = Categories.shared.getGeneralCategory(for: record.categoryID) {
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
