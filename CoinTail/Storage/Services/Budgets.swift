//
//  Budgets.swift
//  CoinTail
//
//  Created by Eugene on 04.07.23.
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


final class Budgets {
    
    static let shared = Budgets()
    
    var budgets: [BudgetClass] {
        get {
            return RealmService.shared.budgetsArr
        }
    }
    
    // Добавить бюджет
    func addBudget(_ budget: BudgetClass) {
        RealmService.shared.write(budget, BudgetClass.self)
    }
    
    // Получить бюджет по его ID
    func getBudget(for id: ObjectId) -> BudgetClass? {
        return budgets.filter { $0.id == id }.first
    }
    
    // Получить активный бюджет по названию категории и валюте
    func getBudget(for categoryName: String, withCurrency selectedCurrency: String) -> Bool? {
        let budget: BudgetClass? = budgets.filter {
            guard let category = Categories.shared.getCategory(for: $0.categoryID) else {
                SentryManager.shared.capture(error: "No category to get budget", level: .error)
                
                return false
            }
            
            return category.name == categoryName && $0.currency == selectedCurrency }.last
        let activeBudgetByCategory: Bool = budget?.isActive ?? false
        
        return (budget != nil) && activeBudgetByCategory
    }
    
    // Отредактировать бюджет по его ID
    func editBudget(replacingBudget: BudgetClass, completion: ((Bool) -> Void)? = nil) {
        RealmService.shared.update(replacingBudget, BudgetClass.self)
        
        completion?(true)
    }
    
    // Удаляет бюджет по его ID
    func deleteBudget(for id: ObjectId, completion: ((Bool) -> Void)? = nil) {
        guard let budget: BudgetClass = getBudget(for: id) else {
            SentryManager.shared.capture(error: "No budget to delete", level: .error)
            completion?(false)
            
            return
        }
        
        RealmService.shared.delete(budget, BudgetClass.self)

        completion?(true)
    }
    
}
