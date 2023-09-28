//
//  Subcategory.swift
//  CoinTail
//
//  Created by Eugene on 21.09.23.
//

import UIKit


struct Subcategory: CategoryProtocol, Equatable {
    var id: Int
    var name: String
    var color: UIColor
    var image: UIImage?
    var parentCategory: Int
}
