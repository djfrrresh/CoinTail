//
//  Categories.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
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


final class Categories {
    
    static let shared = Categories()
    
    private let realmService = RealmService.shared
    
    var totalCategories = [CategoryClass]()
    
    var categories: [CategoryClass] {
        get {
            return RealmService.shared.categoriesArr
        }
    }
    var subcategories: [SubcategoryClass] {
        get {
            return RealmService.shared.subcategoriesArr
        }
    }
    
    // Получить категории по типам 
    func getCategories(for sectionType: RecordType) -> [CategoryClass] {
        switch sectionType {
        case .expense:
            return totalCategories.filter { $0.type == RecordType.expense.rawValue }
        case .income:
            return totalCategories.filter { $0.type == RecordType.income.rawValue }
        case .allOperations:
            return totalCategories
        }
    }
        
    //  Добавление новой категории
    func addNewCategory(_ category: CategoryClass) {
        RealmService.shared.write(category, CategoryClass.self)
    }
    
    //  Добавление новой подкатегории
    func addNewSubcategory(subcategory: SubcategoryClass, for categoryID: ObjectId) {
        RealmService.shared.write(subcategory, SubcategoryClass.self)
        
        addSubcategoryToCategory(
            for: categoryID,
            subcategoryID: subcategory.id
        )
    }
    
    // Добавление ID подкатегории к категории
    private func addSubcategoryToCategory(for categoryID: ObjectId, subcategoryID: ObjectId) {
        do {
            try realmService.realm?.write {
                guard let category = realmService.realm?.object(ofType: CategoryClass.self, forPrimaryKey: categoryID) else { return }
                category.subcategories.append(subcategoryID)
            }
        } catch let error {
            print("Error adding subcategory to category: \(error)")
        }
    }
    
    // Обновить категории в коллекции
    func categoriesUpdate(records: [RecordClass]) {
        var uniqueCategoryIDs = Set<ObjectId>()
        var newCategories = [CategoryClass]()
        
        for record in records {
            let categoryID: ObjectId
            if let subcategory = getSubcategory(for: record.categoryID) {
                // Если это подкатегория, берем идентификатор родительской категории
                categoryID = subcategory.parentCategory
            } else {
                categoryID = record.categoryID
            }
            
            // Проверяем, был ли уже добавлен id категории
            if !uniqueCategoryIDs.contains(categoryID) {
                if let category = getCategory(for: categoryID) {
                    newCategories.append(category)
                } else {
                    continue
                }
                
                uniqueCategoryIDs.insert(categoryID)
            }
        }
                
        totalCategories = newCategories        
    }
    
    // Получить ID категории по ее названию
    func getCategoryID(for name: String, type: RecordType) -> ObjectId? {
        return categories.filter { $0.name == name }.first?.id
    }
    
    // Получить категорию по ID
    func getCategory(for id: ObjectId) -> CategoryClass? {
        return categories.filter { $0.id == id }.first
    }
    
    // Получить подкатегорию по ID
    func getSubcategory(for id: ObjectId) -> SubcategoryClass? {
        return subcategories.filter { $0.id == id }.first
    }
    
    // Получить категорию или подкатегорию по ID
    func getGeneralCategory(for id: ObjectId) -> CategoryProtocol? {
        var category: CategoryProtocol?
        if let nonOptionalCategory = getCategory(for: id) {
            category = nonOptionalCategory
        }
        if let nonOptionalSubcategory = getSubcategory(for: id) {
            category = nonOptionalSubcategory
        }
        
        return category
    }
    
    // Отредактировать категорию по его ID
    func editCategory(replacingCategory: CategoryClass, completion: ((Bool) -> Void)? = nil) {
        RealmService.shared.update(replacingCategory, CategoryClass.self)
        
        completion?(true)
    }
    
    // Отредактировать подкатегорию по его ID
    func editSubcategory(replacingSubcategory: SubcategoryClass, completion: ((Bool) -> Void)? = nil) {
        RealmService.shared.update(replacingSubcategory, SubcategoryClass.self)
        
        completion?(true)
    }
    
    // Помечает удаленной категорию по его ID
    func deleteCategory(for id: ObjectId, completion: ((Bool) -> Void)? = nil) {
        guard let category: CategoryClass = getCategory(for: id) else {
            completion?(false)
            return
        }
        
        try? RealmService.shared.realm?.write {
            category.isDeleted = true
            
            // Помечает удаленными подкатегории
            for subcategoryId in category.subcategories {
                deleteSubcategory(for: subcategoryId)
            }
        }
        
        completion?(true)
    }
    
    // Помечает удаленной подкатегорию по его ID
    func deleteSubcategory(for id: ObjectId, completion: ((Bool) -> Void)? = nil) {
        guard let subcategory: SubcategoryClass = getSubcategory(for: id) else {
            completion?(false)
            return
        }
        
        try? RealmService.shared.realm?.write {
            subcategory.isDeleted = true
        }
        
        completion?(true)
    }
    
    // Создает дефолтные категории разных типов
    func createDefaultCategoriesIfNeeded() {
        // Проверяем, есть ли категории в базе данных
        guard realmService.read(CategoryClass.self).isEmpty else {
            return
        }
        
        let incomeCategories: [CategoryClass] = [
            createDefaultCategory(name: "Salary".localized(), color: Colors.shared.salaryColor, image: "💸", type: RecordType.income.rawValue),
            createDefaultCategory(name: "Debt repayment".localized(), color: Colors.shared.debtRepaymentColor, image: "↩️", type: RecordType.income.rawValue),
            createDefaultCategory(name: "Side job".localized(), color: Colors.shared.sideJobColor, image: "💵", type: RecordType.income.rawValue),
            createDefaultCategory(name: "Pleasant finds".localized(), color: Colors.shared.pleasantFindsColor, image: "💝", type: RecordType.income.rawValue)
        ]

        let expenseCategories: [CategoryClass] = [
            createDefaultCategory(name: "Transport".localized(), color: Colors.shared.transportColor, image: "🚎", type: RecordType.expense.rawValue),
            createDefaultCategory(name: "Groceries".localized(), color: Colors.shared.gloceryColor, image: "🥦", type: RecordType.expense.rawValue),
            createDefaultCategory(name: "Cloths".localized(), color: Colors.shared.clothsColor, image: "👔", type: RecordType.expense.rawValue),
            createDefaultCategory(name: "Gym".localized(), color: Colors.shared.gymColor, image: "💪", type: RecordType.expense.rawValue),
            createDefaultCategory(name: "Service".localized(), color: Colors.shared.serviceColor, image: "⚙️", type: RecordType.expense.rawValue),
            createDefaultCategory(name: "Subscription".localized(), color: Colors.shared.subscriptionColor, image: "💎", type: RecordType.expense.rawValue),
            createDefaultCategory(name: "Health".localized(), color: Colors.shared.healthColor, image: "💊", type: RecordType.expense.rawValue),
            createDefaultCategory(name: "Cafe".localized(), color: Colors.shared.cafeColor, image: "🍔", type: RecordType.expense.rawValue)
        ]

        for category in incomeCategories {
            realmService.write(category, CategoryClass.self)
        }

        for category in expenseCategories {
            realmService.write(category, CategoryClass.self)
        }
    }
    
    private func createDefaultCategory(name: String, color: String?, image: String, type: String) -> CategoryClass {
        let category = CategoryClass()
        category.name = name
        category.color = color
        category.image = image
        category.type = type
        
        return category
    }
    
}
