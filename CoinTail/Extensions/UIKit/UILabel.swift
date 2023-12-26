//
//  UILabel.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit


extension UILabel {
    
    convenience init(text: String, alignment: NSTextAlignment = .center, color: UIColor = UIColor(named: "black") ?? .black, numOfLines: Int = 0, fontSize: CGFloat = 16) {
        self.init()
        
        self.text = text
        self.textColor = color
        self.textAlignment = alignment
        
        self.numberOfLines = numOfLines
        self.font = .systemFont(ofSize: fontSize)
        
        self.adjustsFontSizeToFitWidth = true
    }
    
}
