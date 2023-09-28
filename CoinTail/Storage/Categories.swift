//
//  Categories.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


final class Categories {
    
    static let shared = Categories()
    
    var totalCategories = [Category]()
    
    var lastCategoryID = 11
    var lastSubcategoryID = 5
    
    // Стандартные категории
    var categories: [RecordType: [Category]] = [
        .income: [
            Category(
                id: 0,
                name: "Salary".localized(),
                color: Colors.shared.salaryColor ?? .clear,
                image: UIImage(systemName: "dollarsign"),
                type: .income,
                subcategories: [
                    0, 1
                ]
            ),
            Category(
                id: 1,
                name: "Debt repayment".localized(),
                color: Colors.shared.debtRepaymentColor ?? .clear,
                image: UIImage(systemName: "creditcard"),
                type: .income
            ),
            Category(
                id: 2,
                name: "Side job".localized(),
                color: Colors.shared.sideJobColor ?? .clear,
                image: UIImage(systemName: "briefcase"),
                type: .income
            ),
            Category(
                id: 3,
                name: "Pleasant finds".localized(),
                color: Colors.shared.pleasantFindsColor ?? .clear,
                image: UIImage(systemName: "heart"),
                type: .income,
                subcategories: [
                    5
                ]
            )
        ],
        
        .expense: [
            Category(
                id: 4,
                name: "Transport".localized(),
                color: Colors.shared.transportColor ?? .clear,
                image: UIImage(systemName: "car"),
                type: .expense,
                subcategories: [
                    2
                ]
            ),
            Category(
                id: 5,
                name: "Cloths".localized(),
                color: Colors.shared.clothsColor ?? .clear,
                image: UIImage(systemName: "tshirt"),
                type: .expense
            ),
            Category(
                id: 6,
                name: "Groceries".localized(),
                color: Colors.shared.gloceryColor ?? .clear,
                image: UIImage(systemName: "cart"),
                type: .expense,
                subcategories: [
                    3, 4
                ]
            ),
            Category(
                id: 7,
                name: "Gym".localized(),
                color: Colors.shared.gymColor ?? .clear,
                image: UIImage(systemName: "figure.walk"),
                type: .expense
            ),
            Category(
                id: 8,
                name: "Service".localized(),
                color: Colors.shared.serviceColor ?? .clear,
                image: UIImage(systemName: "gearshape"),
                type: .expense
            ),
            Category(
                id: 9,
                name: "Subscription".localized(),
                color: Colors.shared.subscriptionColor ?? .clear,
                image: UIImage(systemName: "gamecontroller"),
                type: .expense
            ),
            Category(
                id: 10,
                name: "Health".localized(),
                color: Colors.shared.healthColor ?? .clear,
                image: UIImage(systemName: "cross.case"),
                type: .expense
            ),
            Category(
                id: 11,
                name: "Cafe".localized(),
                color: Colors.shared.cafeColor ?? .clear,
                image: UIImage(systemName: "fork.knife"),
                type: .expense
            )
        ]
    ]
    
    var subcategories: [Subcategory] = [
        Subcategory(
            id: 0,
            name: "First Job",
            color: Colors.shared.firstJobColor ?? .clear,
            image: UIImage(systemName: "bag.badge.plus"),
            parentCategory: 0
        ),
        Subcategory(
            id: 1,
            name: "Second Job",
            color: Colors.shared.secondJobColor ?? .clear,
            image: UIImage(systemName: "eurosign"),
            parentCategory: 0
        ),
        Subcategory(
            id: 2,
            name: "Bus",
            color: Colors.shared.busColor ?? .clear,
            image: UIImage(systemName: "bus.fill"),
            parentCategory: 4
        ),
        Subcategory(
            id: 3,
            name: "Walmart",
            color: Colors.shared.walmartColor ?? .clear,
            image: UIImage(systemName: "basket"),
            parentCategory: 6
        ),
        Subcategory(
            id: 4,
            name: "Spar",
            color: Colors.shared.sparColor ?? .clear,
            image: UIImage(systemName: "cart.badge.questionmark"),
            parentCategory: 6
        ),
        Subcategory(
            id: 5,
            name: "Jacket pocket",
            color: Colors.shared.jacketPocketColor ?? .clear,
            image: UIImage(systemName: "banknote"),
            parentCategory: 3
        )
    ]
    
    // Иконки для создаваемых категорий
    var createCategoryImages = [
        "trash",
        "text.book.closed",
        "graduationcap",
        "mustache",
        "die.face.3",
        "stethoscope",
        "theatermasks",
        "airplane",
        "bicycle",
        "fuelpump"
    ]
    
    // Получить категории по типам на главном меню
    func getCategories(for sectionType: RecordType) -> [Category] {
        switch sectionType {
        case .expense:
            return totalCategories.filter { $0.type == .expense }
        case .income:
            return totalCategories.filter { $0.type == .income }
        case .allOperations:
            return totalCategories
        }
    }
        
    //  Добавление новой категории
    func addNewCategory(_ category: Category, type: RecordType) {
        categories[type]?.append(category)
    }
    
    //  Добавление новой подкатегории
    func addNewSubategory(_ subcategory: Subcategory) {
        subcategories.append(subcategory)
    }
    
    // Обновить категории в коллекции
    func categoriesUpdate(records: [Record]) {
        var newCategories = [Category]()
                
        for record in records where !newCategories.contains(where: { $0.id == record.categoryID }) {
            guard let category = getCategory(for: record.categoryID) else { return }

            newCategories.append(category)
        }
        
        totalCategories = newCategories
    }
    
    func getCategoryID(for name: String, type: RecordType) -> Int {
        return categories[type]?.filter { $0.name == name }.first?.id ?? 0
    }
    
    // Получить подкатегорию по ID
    func getCategory(for id: Int) -> Category? {
        let allCategories = categories.values.flatMap { $0 }

        return allCategories.filter { $0.id == id }.first
    }
    
    // Получить подкатегорию по ID
    func getSubcategory(for id: Int) -> Subcategory? {
        return subcategories.filter { $0.id == id }.first
    }
    
}
