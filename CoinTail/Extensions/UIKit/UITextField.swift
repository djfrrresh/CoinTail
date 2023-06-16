//
//  UITextField.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit
import EasyPeasy


extension UITextField {
    
    convenience init(defaultText: String = "", background: UIColor, keyboard: UIKeyboardType, placeholder: String) {
        self.init()
        
        // Граница текстового поля и радиус
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        // Автокоррекция
        self.autocorrectionType = .no
        
        self.backgroundColor = background
        self.keyboardType = keyboard
        self.placeholder = placeholder
        self.text = defaultText
        
        // Отступ слева
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftViewMode = .always
        
        self.easy.layout([Height(56)])
    }
    
}
