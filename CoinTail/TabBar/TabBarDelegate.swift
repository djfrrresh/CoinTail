//
//  TabBarDelegate.swift
//  CoinTail
//
//  Created by Eugene on 23.11.23.
//

import UIKit


// Плавный переход между контроллерами на TabBar'е
extension TabBar: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view,
              let toView = viewController.view else { return false }

        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
    
}
