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
            errorAlert("Missing value in amount field".localized())
        } else if missingCategory {
            errorAlert("No category selected".localized())
        }
        // TODO: premium
//        else if account != nil && account?.currency != "\(selectedCurrency)" {
//            errorAlert("You cannot specify an account for this transaction with another currency".localized())
//        }
        else {
            guard let categoryID = self.categoryID,
                  let category = Categories.shared.getGeneralCategory(for: categoryID) else { return }

            completion?(category.id)
        }
    }
    
}
