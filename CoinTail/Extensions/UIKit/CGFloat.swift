//
//  CGFloat.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit


extension CGFloat {
    
    // Возвращает случайный флоат для UIColor
    static func random() -> CGFloat {
        return CGFloat(CGFloat.random(in: 0...1)) / CGFloat(UInt32.max)
    }
    
}
