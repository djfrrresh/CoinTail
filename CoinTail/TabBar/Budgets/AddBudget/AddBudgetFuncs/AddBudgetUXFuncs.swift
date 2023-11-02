//
//  AddBudgetUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit
import RealmSwift


extension AddBudgetVC: SendCategoryID {
    
    // Присылает категорию с SelectCategoryVC
    func sendCategoryData(id: ObjectId) {
        self.budgetCategoryID = id

        let category = Categories.shared.getCategory(for: id)

        self.budgetCategory = category?.name
    }
    
    // Таргеты для кнопок
    func addBudgetTargets() {
        deleteBudgetButton.addTarget(self, action: #selector(removeBudget), for: .touchUpInside)
    }
    
    // Проверка поля Amount и текста из кнопки категории на наличие данных в них
    func budgetValidation(amount: Double, categoryText: String, isEditingBudget: Bool, completion: ((Double, ObjectId) -> Void)? = nil) {
//        guard let currencyText = currencyButton.titleLabel?.text else { return }
//        
//        let selectedCurrency = Currencies.shared.getCurrencyClass(for: currencyText)
//        let missingAmount = amount == 0
//        let missingCategory = categoryText == AddBudgetVC.defaultCategory
//
//        //TODO: bad validation if editing
//        if missingAmount {
//            errorAlert("Missing value in amount field".localized())
//        } else if missingCategory {
//            errorAlert("No category selected".localized())
//        } else if Budgets.shared.getBudget(for: categoryText, withCurrency: "\(selectedCurrency)") ?? false {
//            errorAlert("There is already a budget for this category and currency".localized())
//        } else {
//            guard let categoryID = budgetCategoryID else { return }
//            
//            completion?(amount, categoryID)
//        }
    }
    
}
