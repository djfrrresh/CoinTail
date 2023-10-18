//
//  HomeCVCategory.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit
import RealmSwift


protocol CategoryProtocol {
    var id: Int { get set }
    var name: String { get set }
    var color: UIColor { get set }
    var image: UIImage? { get set }
}

struct Category: CategoryProtocol, Equatable {
    var id: Int
    var name: String
    var color: UIColor
    var image: UIImage?
    var type: RecordType?
    var subcategories: [Int]?
    var isEditable: Bool = true
}

class CategoryClass: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String = ""
    @Persisted var color: String? // HEX-код цвета
    @Persisted var image: String? // Путь к изображению
    @Persisted var type: String?
    @Persisted var subcategories = List<ObjectId>()
}
