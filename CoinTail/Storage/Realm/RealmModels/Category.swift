//
//  HomeCVCategory.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit
import RealmSwift


protocol CategoryProtocol {
    var id: ObjectId { get set }
    var name: String { get set }
    var color: String? { get set }
    var image: String? { get set }
}

class CategoryClass: Object, CategoryProtocol {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String = ""
    @Persisted var color: String?
    @Persisted var image: String?
    @Persisted var type: String?
    @Persisted var subcategories: List<ObjectId>
}
