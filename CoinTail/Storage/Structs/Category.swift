//
//  HomeCVCategory.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit


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
}
