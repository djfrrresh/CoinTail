//
//  UIKit.swift
//  CoinTail
//
//  Created by Eugene on 29.11.22.
//

import UIKit


extension UIButton {
    convenience init(name: String) {
        self.init()
        self.setTitle(name, for: .normal)
    }
}
extension UITextField {
    convenience init(defaultText: String) {
        self.init()
        self.text = defaultText
    }
}

extension UILabel {
    convenience init(text: String, alignment: NSTextAlignment = .left) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.textColor = .black
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
    }
}
