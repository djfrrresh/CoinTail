//
//  AddBudgetUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit


extension AddBudgetVC: SendSubcategoryID {
    
    // Присылает категорию с SelectCategoryVC
    //TODO: переделать под категории из хедера
    func sendSubcategoryData(id: Int) {
//        self.budgetCategoryID = id
//
//        categoryButton.setTitle(id.name, for: .normal)
    }
    
    func setCurrency(currencyCode: String) {
        self.currency = Currencies.shared.getCurrency(for: currencyCode)
    }
    
    // Таргеты для кнопок
    func addBudgetTargets() {
        saveBudgetButton.addTarget(self, action: #selector(saveBudgetAction), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(selectCategoryAction), for: .touchUpInside)
        currencyButton.addTarget(self, action: #selector(changeCurrency), for: .touchUpInside)
    }
    
    // Проверка поля Amount и текста из кнопки категории на наличие данных в них
    func budgetValidation(amount: Double, categoryText: String, isEditingBudget: Bool, completion: ((Double, Category) -> Void)? = nil) {
        let missingAmount = amount == 0
        let missingCategory = categoryText == AddBudgetVC.defaultCategory
        let budgetCategory = Budgets.shared.getBudget(for: categoryText)
        let activeBudgetByCategory = budgetCategory?.isActive

        if missingAmount {
            errorAlert("Missing value in amount field".localized())
        } else if missingCategory {
            errorAlert("No category selected".localized())
        } else if budgetCategory != nil && !isEditingBudget && activeBudgetByCategory! {
            errorAlert("There is already a budget for this category".localized())
        } else {
            // TODO: передать категорию self.budgetCategory
//            guard let category = self.budgetCategory else { return }
            let category = Category(id: 111, name: "Example", color: .black)
            completion?(amount, category)
        }
    }
    
}
