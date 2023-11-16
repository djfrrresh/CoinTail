//
//  AddOperationUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


extension AddOperationVC: SendSubcategoryID, SendCategoryID, AddOperationCellDelegate {
    
    func cell(didUpdateOperationAmount amount: String?) {
        operationAmount = amount
    }
    
    func cell(didUpdateOperationDescription description: String?) {
        operationDescription = description ?? ""
    }
    
    func cell(didUpdateOperationDate date: Date) {
        operationDate = date
    }
    
    func sendCategoryData(id: ObjectId) {
        guard let category = Categories.shared.getCategory(for: id) else { return }

        categoryID = id
        operationCategory = category.name
    }
    
    func sendSubcategoryData(id: ObjectId) {
        guard let subcategory = Categories.shared.getSubcategory(for: id) else { return }

        subcategoryID = id
        operationCategory = subcategory.name
    }
    
    // Установка таргетов для кнопок
    func setTargets() {
        deleteOperationButton.addTarget(self, action: #selector(removeOperation), for: .touchUpInside)
    }
    
    // Проверка поля Amount и текста из кнопки категории на наличие данных в них
    func recordValidation(amount: Double, categoryText: String, completion: ((Double, ObjectId) -> Void)? = nil) {
        let missingAmount = "\(amount)" == "" || amount == 0
        let missingCategory = categoryText == ""

        var account: AccountClass?
        if let accountID = self.accountID {
            account = Accounts.shared.getAccount(for: accountID)
        }

        if missingAmount {
            errorAlert("Missing value in amount field".localized())
        } else if missingCategory {
            errorAlert("No category selected".localized())
        } else if account != nil && account?.currency != "\(selectedCurrency)" {
            errorAlert("You cannot specify an account for this transaction with another currency!".localized())
        } else {
            //TODO: subcategories
            var category: ObjectId = ObjectId()
            if let subcategoryID = self.subcategoryID {
                category = subcategoryID
            } else if let categoryID = self.categoryID {
                category = categoryID
            }

            completion?(amount, category)
        }
    }
    
}
