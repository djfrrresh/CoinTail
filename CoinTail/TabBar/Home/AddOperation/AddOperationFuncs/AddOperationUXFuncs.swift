//
//  AddOperationUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension AddOperationVC: SendSubcategoryID, SendAccountID, SendCategoryID {
    
    func sendCategoryData(id: Int) {
        self.categoryID = id
        
        let category = Categories.shared.getCategory(for: id)
        
        categoryButton.setTitle(category?.name, for: .normal)
    }
    
    func sendSubcategoryData(id: Int) {
        self.subcategoryID = id
        
        let subcategory = Categories.shared.getSubcategory(for: id)
        
        categoryButton.setTitle(subcategory?.name, for: .normal)
    }
    
    func sendAccountData(accountID: Int) {
        self.accountID = accountID
        
        guard let account = Accounts.shared.getAccount(for: accountID) else { return }
        
        accountButton.setTitle(account.name, for: .normal)
    }
    
    func setCurrency(currencyCode: String) {
        self.currency = Currencies.shared.getCurrency(for: currencyCode)
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
    func recordValidation(amount: Double, categoryText: String, accountText: String, completion: ((Double, Category) -> Void)? = nil) {
        let missingAmount = abs(amount) == 0
        let missingCategory = categoryText == AddOperationVC.defaultCategory
        let missingAccount = accountText == AddOperationVC.defaultAccount

        if missingAmount {
            errorAlert("Missing value in amount field".localized())
        } else if missingCategory {
            errorAlert("No category selected".localized())
        } else if missingAccount && self.accountID != nil {
            errorAlert("No account selected".localized())
        } else {
            //TODO: subcategory
            guard let subcategoryID = self.subcategoryID,
                  let subcategory = Categories.shared.getSubcategory(for: subcategoryID)?.parentCategory,
                  let category = Categories.shared.getCategory(for: subcategory) else { return }
            
            completion?(amount, category)
        }
    }
    
}
