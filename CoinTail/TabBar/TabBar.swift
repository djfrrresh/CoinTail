//
//  TabBar.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit
import EasyPeasy


class TabBar: UITabBarController {
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self

        // Навигационные контроллеры (с которых можно переходить в другие)
        let homeVC = UINavigationController(rootViewController: HomeVC())
        let budgetsVC = UINavigationController(rootViewController: BudgetsVC())
        let accountsVC = UINavigationController(rootViewController: AccountsVC())
        let settingsVC = UINavigationController(rootViewController: SettingsVC())
                
        homeVC.title = "Home".localized()
        budgetsVC.title = "Budgets".localized()
        accountsVC.title = "Accounts".localized()
        settingsVC.title = "Settings".localized()
        
        UITabBar.appearance().backgroundColor = UIColor(named: "tabBarBackground") // Цвет фона TabBar'а
        UITabBar.appearance().tintColor = UIColor(named: "selectedScreen") // Цвет выбранной иконки и текста
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "unselectedScreen") // Цвет невыбранных иконок
        
        // Установка контроллеров на TabBar
        self.setViewControllers([homeVC, budgetsVC, accountsVC, settingsVC], animated: false)
                        
        guard let items = self.tabBar.items else { return }
        let images = ["house.fill", "chart.bar.xaxis", "creditcard.fill", "gearshape.fill"]
        
        // Установка иконок
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
    }
    
}

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
