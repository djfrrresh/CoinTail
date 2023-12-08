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
            
            indicator.center = CGPointMake(buttonWidth/2, buttonHeight/2)
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

extension UIBezierPath {
    
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero) {
        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero {
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero {
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero {
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
    }
    
}
