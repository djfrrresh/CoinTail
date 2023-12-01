//
//  Subcategory.swift
//  CoinTail
//
//  Created by Eugene on 21.09.23.
//

import UIKit
import RealmSwift


class SubcategoryClass: Object, CategoryProtocol {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String = ""
    @Persisted var color: String?
    @Persisted var image: String?
    @Persisted var isDeleted: Bool = false
    @Persisted var parentCategory: ObjectId
}
