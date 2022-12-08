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
    convenience init(default_text: String) {
        self.init()
        self.text = default_text
    }
}
