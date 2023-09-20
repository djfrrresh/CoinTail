//
//  AddOperationUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension AddOperationVC: SendСategory, SendAccount {
    
    func sendCategoryData(category: Category) {
        self.category = category
        categoryButton.setTitle(category.name, for: .normal)
    }
    
    func sendAccountData(account: Account) {
        self.account = account
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
        } else if missingAccount && self.account != nil {
            errorAlert("No account selected".localized())
        } else {
            guard let category = self.category else { return }
            completion?(amount, category)
        }
    }
    
}
