//
//  UIColor.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit


extension UIColor {
    
    // Возвращает случайный цвет
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
    
}
