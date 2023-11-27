//
//  TabBar.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//

import UIKit


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
