//
//  UIView.swift
//  CoinTail
//
//  Created by Eugene on 18.10.23.
//

import UIKit


extension UIView {
    
    func cornerRadiusBottom(radius: CGFloat, clipsToBounds: Bool = true) {
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func cornerRadiusTop(radius: CGFloat, clipsToBounds: Bool = true) {
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func cornerRadiusLeft(radius: CGFloat, clipsToBounds: Bool = true) {
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    func cornerRadiusRight(radius: CGFloat, clipsToBounds: Bool = true) {
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    
}
