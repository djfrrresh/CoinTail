//
//  UIView.swift
//  CoinTail
//
//  Created by Eugene on 18.10.23.
//

import UIKit
import EasyPeasy


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
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    func roundCorners(_ corners: [UIRectCorner], radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        var maskedCorners = CACornerMask()
        for corner in corners {
            switch corner {
            case .topRight:
                maskedCorners.insert(.layerMaxXMinYCorner)
            case .topLeft:
                maskedCorners.insert(.layerMinXMinYCorner)
            case .bottomLeft:
                maskedCorners.insert(.layerMinXMaxYCorner)
            case .bottomRight:
                maskedCorners.insert(.layerMaxXMaxYCorner)
            case .allCorners:
                maskedCorners = CACornerMask()
                maskedCorners.insert(.layerMaxXMaxYCorner)
                maskedCorners.insert(.layerMinXMaxYCorner)
                maskedCorners.insert(.layerMinXMinYCorner)
                maskedCorners.insert(.layerMaxXMinYCorner)
                self.layer.maskedCorners = maskedCorners
                return
            default:
                fatalError("undefined corner")
            }
        }
        self.layer.maskedCorners = maskedCorners
    }
    
    func loadingIndicator(_ show: Bool, centerYInset: CGFloat = 0, color: UIColor = .white) {
        let tag = 9876
        
        if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
            if show {
                indicator.startAnimating()
            } else {
                indicator.stopAnimating()
            }
        } else if show {
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.color = color
            
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            
            indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
            indicator.tag = tag
            
            self.addSubview(indicator)
            if centerYInset != 0 {
                indicator.easy.layout([CenterX(), Top(centerYInset)])
            } else {
                indicator.easy.layout([Center()])
            }
            
            indicator.startAnimating()
        }
    }
    
}
