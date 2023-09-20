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
            Category(name: "Salary".localized(), color: Colors.shared.salaryColor ?? .clear, image: UIImage(systemName: "dollarsign"), type: .income),
            Category(name: "Debt repayment".localized(), color: Colors.shared.debtRepaymentColor ?? .clear, image: UIImage(systemName: "creditcard"), type: .income),
            Category(name: "Side job".localized(), color: Colors.shared.sideJobColor ?? .clear, image: UIImage(systemName: "briefcase"), type: .income),
            Category(name: "Pleasant finds".localized(), color: Colors.shared.pleasantFindsColor ?? .clear, image: UIImage(systemName: "heart"), type: .income)
        ],
        .expense: [
            Category(name: "Transport".localized(), color: Colors.shared.transportColor ?? .clear, image: UIImage(systemName: "car"), type: .expense),
            Category(name: "Cloths".localized(), color: Colors.shared.clothsColor ?? .clear, image: UIImage(systemName: "tshirt"), type: .expense),
            Category(name: "Groceries".localized(), color: Colors.shared.gloceryColor ?? .clear, image: UIImage(systemName: "cart"), type: .expense),
            Category(name: "Gym".localized(), color: Colors.shared.gymColor ?? .clear, image: UIImage(systemName: "figure.walk"), type: .expense),
            Category(name: "Service".localized(), color: Colors.shared.serviceColor ?? .clear, image: UIImage(systemName: "gearshape"), type: .expense),
            Category(name: "Subscription".localized(), color: Colors.shared.subscriptionColor ?? .clear, image: UIImage(systemName: "gamecontroller"), type: .expense),
            Category(name: "Health".localized(), color: Colors.shared.healthColor ?? .clear, image: UIImage(systemName: "cross.case"), type: .expense),
            Category(name: "Cafe".localized(), color: Colors.shared.cafeColor ?? .clear, image: UIImage(systemName: "fork.knife"), type: .expense)
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
        
    //  Добавление новых категорий
    func addNewCategory(_ category: Category, type: RecordType) {
        categories[type]?.append(category)
    }
    
    // Обновить категории в коллекции
    func categoriesUpdate(records: [Record]) {
        var newCategories = [Category]()
        
        for record in records where !newCategories.contains(record.category) {
            newCategories.append(record.category)
        }
        
        totalCategories = newCategories
    }
}
