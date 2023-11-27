//
//  Categories.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

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
    func addSubcategoryToCategory(for categoryID: ObjectId, subcategoryID: ObjectId) {
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
        var newCategories = [CategoryClass]()
                
        for record in records where !newCategories.contains(where: { $0.id == record.categoryID }) {
            guard let category = getCategory(for: record.categoryID) else { return }

            newCategories.append(category)
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
    func editCategory(for id: ObjectId, replacingCategory: CategoryClass, completion: ((Bool) -> Void)? = nil) {
        RealmService.shared.update(replacingCategory, CategoryClass.self)
        
        completion?(true)
    }
    
    // Отредактировать подкатегорию по его ID
    func editSubcategory(for id: ObjectId, replacingSubcategory: SubcategoryClass, completion: ((Bool) -> Void)? = nil) {
        RealmService.shared.update(replacingSubcategory, SubcategoryClass.self)
        
        completion?(true)
    }
    
    // Удаляет категорию по его ID
    func deleteCategory(for id: ObjectId, completion: ((Bool) -> Void)? = nil) {
        guard let category: CategoryClass = getCategory(for: id) else {
            completion?(false)
            return
        }

        // Удаляем подкатегории
        for subcategoryId in category.subcategories {
            deleteSubcategory(for: subcategoryId)
        }
        
        RealmService.shared.delete(category, CategoryClass.self)

        completion?(true)
    }
    
    // Удаляет подкатегорию по его ID
    func deleteSubcategory(for id: ObjectId, completion: ((Bool) -> Void)? = nil) {
        guard let subcategory: SubcategoryClass = getSubcategory(for: id) else {
            completion?(false)
            return
        }
        
        RealmService.shared.delete(subcategory, SubcategoryClass.self)

        completion?(true)
    }
    
}
