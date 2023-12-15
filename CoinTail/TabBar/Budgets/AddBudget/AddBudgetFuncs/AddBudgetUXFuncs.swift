//
//  AddBudgetUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit
import RealmSwift


extension AddBudgetVC: SendCategoryID, SendRegularity, AddBudgetCellDelegate {
    
    func cell(didUpdateBudgetAmount amount: String?) {
        budgetAmount = amount
    }
    
    func sendPeriod(_ period: String) {
        budgetTimePeriod = period
    }
    
    // Присылает категорию с SelectCategoryVC
    func sendCategoryData(id: ObjectId) {
        budgetCategoryID = id

        let category = Categories.shared.getCategory(for: id)
        budgetCategory = category?.name
    }
    
    // Таргеты для кнопок
    func addBudgetTargets() {
        deleteBudgetButton.addTarget(self, action: #selector(removeBudget), for: .touchUpInside)
    }
    
    func budgetValidation(amount: Double, categoryText: String, completion: ((Double, ObjectId) -> Void)? = nil) {
        let missingAmount = "\(amount)" == "" || amount == 0
        let missingCategory = categoryText == ""
        let sameBudget = Budgets.shared.getBudget(for: categoryText, withCurrency: selectedCurrency) ?? false

        if missingAmount {
            infoAlert("Missing value in amount field".localized())
        } else if missingCategory {
            infoAlert("No category selected".localized())
        } else if sameBudget && budgetID == nil {
            infoAlert("There is already a budget for this category and currency".localized())
        } else {
            guard let categoryID = budgetCategoryID else { return }
            
            completion?(amount, categoryID)
        }
    }
    
}
