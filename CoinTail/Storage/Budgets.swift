//
//  Budgets.swift
//  CoinTail
//
//  Created by Eugene on 04.07.23.
//

import UIKit


final class Budgets {
    
    static let shared = Budgets()

    // Массив всех бюджетов
    var budgets = [Budget]()
    
    // TODO: исправить на 0, если отсутствует Mock!
    var budgetID = 3
    
    // Добавить бюджет
    func addNewBudget(budget: Budget) {
        budgets.append(budget)        
    }
    
    // Получить бюджет по его ID
    func getBudget(for id: Int) -> Budget? {
        return budgets.filter { $0.id == id }.first
    }
    
    // Сверить бюджет по категории
    func getBudget(for categoryName: String) -> Budget? {
        return budgets.filter { $0.category.name == categoryName }.last
    }
    
    // Отредактировать бюджет по его ID
    func editBudget(for id: Int, replacingBudget: Budget, completion: ((Bool) -> Void)? = nil) {
        guard let budget = getBudget(for: id) else {
            completion?(false)
            return
        }
        guard let index = budgets.firstIndex(of: budget) else {
            completion?(false)
            return
        }
        
        budgets[index] = replacingBudget
        completion?(true)
    }
    
    // Удаляет бюджет по его ID
    func deleteBudget(for id: Int, completion: ((Bool) -> Void)? = nil) {
        guard let budget = getBudget(for: id) else {
            completion?(false)
            return
        }
        guard let index = budgets.firstIndex(of: budget) else {
            completion?(false)
            return
        }
        
        budgets.remove(at: index)
        completion?(true)
    }
    
}
