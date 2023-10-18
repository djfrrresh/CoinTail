//
//  Budgets.swift
//  CoinTail
//
//  Created by Eugene on 04.07.23.
//

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
    func addNewBudget(_ budget: BudgetClass) {
        RealmService.shared.write(budget, BudgetClass.self)
    }
    
    // Получить бюджет по его ID
    func getBudget(for id: ObjectId) -> BudgetClass? {
        return budgets.filter { $0.id == id }.first
    }
    
    // Получить активный бюджет по названию категории и валюте
    func getBudget(for categoryName: String, withCurrency selectedCurrency: String) -> Bool? {
        let budget: BudgetClass? = budgets.filter {
            guard let category = Categories.shared.getCategory(for: $0.categoryID) else { return false }
            
            return category.name == categoryName && $0.currency == selectedCurrency }.last
        let activeBudgetByCategory: Bool = budget?.isActive ?? false
        
        return (budget != nil) && activeBudgetByCategory
    }
    
    // Отредактировать бюджет по его ID
    func editBudget(for id: ObjectId, replacingBudget: BudgetClass, completion: ((Bool) -> Void)? = nil) {
        RealmService.shared.update(replacingBudget, BudgetClass.self)
        
        completion?(true)
    }
    
    // Удаляет бюджет по его ID
    func deleteBudget(for id: ObjectId, completion: ((Bool) -> Void)? = nil) {
        guard let budget: BudgetClass = getBudget(for: id) else {
            completion?(false)
            return
        }
        
        RealmService.shared.delete(budget, BudgetClass.self)

        completion?(true)
    }
    
}
