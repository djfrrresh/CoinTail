//
//  AddOperationUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


extension AddOperationVC: SendSubcategoryID, SendCategoryID {
    
    func sendCategoryData(id: ObjectId) {
        self.categoryID = id
        
        guard let category = Categories.shared.getCategory(for: id) else { return }
        
        categoryButton.setTitle(category.name, for: .normal)
    }
    
    func sendSubcategoryData(id: ObjectId) {
        self.subcategoryID = id
        
        guard let subcategory = Categories.shared.getSubcategory(for: id) else { return }
        
        categoryButton.setTitle(subcategory.name, for: .normal)
    }
    
    func setCurrency(currencyCode: String) {
        self.currency = Currencies.shared.getCurrencyClass(for: currencyCode)
    }
    
    // Установка таргетов для кнопок
    func setTargets() {
        saveOperationButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(goToSelectCategoryVC), for: .touchUpInside)
        accountButton.addTarget(self, action: #selector(goToAccountsVC), for: .touchUpInside)
        addOperationTypeSwitcher.addTarget(self, action: #selector(switchButtonAction), for: .valueChanged)
        currencyButton.addTarget(self, action: #selector(changeCurrency), for: .touchUpInside)
        amountTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // Проверка поля Amount и текста из кнопки категории на наличие данных в них
    func recordValidation(amount: Double, categoryText: String, accountText: String, completion: ((Double, ObjectId) -> Void)? = nil) {
        guard let currencyText = currencyButton.titleLabel?.text else { return }
        
        let selectedCurrency = currencyText
        let missingAmount = abs(amount) == 0
        let missingCategory = categoryText == AddOperationVC.defaultCategory
        let missingAccount = accountText == AddOperationVC.defaultAccount
        
        var account: AccountClass?
        if let accountID = self.accountID {
            account = Accounts.shared.getAccount(for: accountID)
        }
        
        if missingAmount {
            errorAlert("Missing value in amount field".localized())
        } else if missingCategory {
            errorAlert("No category selected".localized())
        } else if missingAccount && self.accountID != nil {
            errorAlert("No account selected".localized())
        }
        else if account != nil && account?.currency != "\(selectedCurrency)" {
            errorAlert("You cannot specify an account for this transaction with another currency!".localized())
        }
        else {
            //TODO: проверить работу
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
