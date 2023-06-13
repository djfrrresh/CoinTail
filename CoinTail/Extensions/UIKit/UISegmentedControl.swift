//
//  UISegmentedControl.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit
import EasyPeasy


extension UISegmentedControl {
    
    convenience init(height: CGFloat = 32) {
        self.init()
        
        self.layer.cornerRadius = 8
                
        self.easy.layout([Height(height)])
    }
    
}
