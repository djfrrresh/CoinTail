//
//  Subcategory.swift
//  CoinTail
//
//  Created by Eugene on 21.09.23.
//

import UIKit
import RealmSwift


struct Subcategory: CategoryProtocol, Equatable {
    var id: Int
    var name: String
    var color: UIColor
    var image: UIImage?
    var parentCategory: Int
}

class SubcategoryClass: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String = ""
    @Persisted var color: String = ""
    @Persisted var image: String?
    @Persisted var parentCategory: ObjectId
}
