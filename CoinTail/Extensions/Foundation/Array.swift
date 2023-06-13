//
//  Array.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import Foundation


extension Array where Element: Equatable {
    
    // Возвращает уникальные элементы из массива
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
    
}
