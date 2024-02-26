//
//  AddBudgetUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
            guard let categoryID = budgetCategoryID else {
                SentryManager.shared.capture(error: "No category ID for budget", level: .error)
                
                return
            }
            
            completion?(amount, categoryID)
        }
    }
    
}
