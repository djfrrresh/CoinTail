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
    
    // Стандартные категории
    var categories: [RecordType: [Category]] = [
        .income: [
            Category(name: "Salary", color: Colors.shared.salaryColor ?? .clear, image: UIImage(systemName: "dollarsign")!, type: .income),
            Category(name: "Debt repayment", color: Colors.shared.debtRepaymentColor ?? .clear, image: UIImage(systemName: "creditcard")!, type: .income),
            Category(name: "Side job", color: Colors.shared.sideJobColor ?? .clear, image: UIImage(systemName: "briefcase")!, type: .income),
            Category(name: "Pleasant finds", color: Colors.shared.pleasantFindsColor ?? .clear, image: UIImage(systemName: "heart")!, type: .income)
        ],
        .expense: [
            Category(name: "Transport", color: Colors.shared.transportColor ?? .clear, image: UIImage(systemName: "car")!, type: .expense),
            Category(name: "Glocery", color: Colors.shared.gloceryColor ?? .clear, image: UIImage(systemName: "cart")!, type: .expense),
            Category(name: "Cloths", color: Colors.shared.clothsColor ?? .clear, image: UIImage(systemName: "tshirt")!, type: .expense),
            Category(name: "Gym", color: Colors.shared.gymColor ?? .clear, image: UIImage(systemName: "figure.walk")!, type: .expense),
            Category(name: "Service", color: Colors.shared.serviceColor ?? .clear, image: UIImage(systemName: "gearshape")!, type: .expense),
            Category(name: "Subscription", color: Colors.shared.subscriptionColor ?? .clear, image: UIImage(systemName: "gamecontroller")!, type: .expense),
            Category(name: "Health", color: Colors.shared.healthColor ?? .clear, image: UIImage(systemName: "cross.case")!, type: .expense),
            Category(name: "Cafe", color: Colors.shared.cafeColor ?? .clear, image: UIImage(systemName: "fork.knife")!, type: .expense)
        ]
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
        
    //  Добавление новых категорий
    func addNewCategory(_ category: Category, type: RecordType) {
        categories[type]?.append(category)
    }
    
    func categoriesUpdate(records: [Record]) {
        var newCategories = [Category]()
        for record in records {
            if !newCategories.contains(record.category) {
                newCategories.append(record.category)
            }
        }
        totalCategories = newCategories
    }
}
