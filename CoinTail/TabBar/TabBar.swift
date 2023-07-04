//
//  TabBar.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit


class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        // Навигационные контроллеры (с которых можно переходить в другие)
        let homeVC = UINavigationController(rootViewController: HomeVC())
        let budgetsVC = UINavigationController(rootViewController: BudgetsVC())
        let settingsVC = UINavigationController(rootViewController: SettingsVC())
                
        homeVC.title = "Home"
        budgetsVC.title = "Budgets"
        settingsVC.title = "Settings"
                
        // Цвет фона TabBar'а
        UITabBar.appearance().backgroundColor = .systemGray6
        // Цвет иконок и текста
        UITabBar.appearance().tintColor = .black
        
        // Установка контроллеров на TabBar
        self.setViewControllers([homeVC, budgetsVC, settingsVC], animated: false)
                        
        guard let items = self.tabBar.items else { return }
        
        let images = ["house", "target", "gear"]
        
        // Установка иконок
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
    }
    
}

// Плавный переход между контроллерами на TabBar'е
extension TabBar: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else { return false }

        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
    
}
