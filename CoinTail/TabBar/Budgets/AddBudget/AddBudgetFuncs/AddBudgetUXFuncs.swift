//
//  AddBudgetUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit


extension AddBudgetVC: SendСategoryData {
    
    // Присылает категорию с SelectCategoryVC
    func sendCategoryData(category: Category) {
        self.budgetCategory = category
        
        categoryButton.setTitle(category.name, for: .normal)
    }
    
    // Таргеты для кнопок
    func addBudgetTargets() {
        saveBudgetButton.addTarget(self, action: #selector(saveBudgetAction), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(selectCategoryAction), for: .touchUpInside)
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
            guard let category = self.budgetCategory else { return }
            completion?(amount, category)
        }
    }
    
}
