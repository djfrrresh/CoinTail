//
//  AddOperationUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


extension AddOperationVC: SendSubcategoryID, SendAccountID, SendCategoryID {
    
    func sendCategoryData(id: Int) {
        self.categoryID = id
        
        guard let category = Categories.shared.getCategory(for: id) else { return }
        
        categoryButton.setTitle(category.name, for: .normal)
    }
    
    func sendSubcategoryData(id: Int) {
        self.subcategoryID = id
        
        guard let subcategory = Categories.shared.getSubcategory(for: id) else { return }
        
        categoryButton.setTitle(subcategory.name, for: .normal)
    }
    
    func sendAccountData(id: ObjectId) {
        self.accountID = id
        
        guard let account = Accounts.shared.getAccount(for: id) else { return }
        
        accountButton.setTitle(account.name, for: .normal)
    }
    
    func setCurrency(currencyCode: String) {
        self.currency = Currencies.shared.getCurrency(for: currencyCode)
    }
    
    // Установка наблюдателей. При выходе с контроллера, где имеется наблюдатель, наблюдатель уничтожается вместе с контроллером
    func startObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    func recordValidation(amount: Double, categoryText: String, accountText: String, completion: ((Double, Int) -> Void)? = nil) {
        guard let currencyText = currencyButton.titleLabel?.text else { return }
        
        let selectedCurrency: Currency = Currencies.shared.getCurrency(for: currencyText)
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
        } else if account != nil && account?.currency != "\(selectedCurrency)" {
            errorAlert("You cannot specify an account for this transaction with another currency!".localized())
        } else {
            //TODO: add subcategory
            guard let categoryID = self.categoryID else { return }
            
            completion?(amount, categoryID)
        }
    }
    
}
