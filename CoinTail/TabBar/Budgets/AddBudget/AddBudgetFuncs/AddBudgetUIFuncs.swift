//
//  AddBudgetUIFuncs.swift
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
import EasyPeasy


extension AddBudgetVC {
    
    func setupUI(with budget: BudgetClass) {
        if let categoryName = Categories.shared.getCategory(for: budget.categoryID)?.name {
            budgetCategory = categoryName
        }
        budgetCategoryID = budget.categoryID
        selectedCurrency = budget.currency
        budgetAmount = "\(budget.amount)"
        
        let calendar = Calendar.current
        let startDate = budget.startDate
        let untilDate = budget.untilDate
        let components = calendar.dateComponents([.day], from: startDate, to: untilDate)
        
        if let days = components.day {
            if days == 7 {
                budgetTimePeriod = "Week".localized()
            } else if days == 30 {
                budgetTimePeriod = "Month".localized()
            } else {
                return
            }
        }
        
        deleteBudgetButton.isHidden = false
    }
    
    func addBudgetSubviews() {
        self.view.addSubview(addBudgetCV)
        self.view.addSubview(deleteBudgetButton)
        
        let height: CGFloat = (budgetID != nil ? 3 : 4) * 48
        addBudgetCV.easy.layout([
            Left(16),
            Right(16),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            Height(height)
        ])
        
        deleteBudgetButton.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(addBudgetCV, .bottom),
            Height(52)
        ])
    }
    
    func addBudgetNavBar() {
        let saveButton = UIBarButtonItem(title: "Save".localized(), style: .plain, target: self, action: #selector(saveBudgetAction))
            
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    //TODO: вынести в basicvc
    func updateCell(at indexPath: IndexPath, text: String) {
        if let cell = addBudgetCV.cellForItem(at: indexPath) as? AddBudgetCell {
            cell.updateSubMenuLabel(text)
        }
    }
    
}
