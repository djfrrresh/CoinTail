//
//  UIButton.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit
import EasyPeasy


extension UIButton {
    
    convenience init(name: String, background: UIColor, textColor: UIColor) {
        self.init()
        
        // Радиус и граница кнопки
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        
        // Цвета
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = background
        self.setTitleColor(textColor, for: .normal)
        
        self.setTitle(name, for: .normal)
        
        self.easy.layout([Height(56)])
    }
    
}
