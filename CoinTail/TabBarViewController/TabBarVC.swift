//
//  TabBarViewController.swift
//  CoinTail
//
//  Created by Eugene on 04.10.22.
//

import UIKit


class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Указаные контроллеры будут управляться через TabBar
        let vc1 = HomeViewController()
        let vc2 = SettingsViewController(currencyVC: CurrencyTableVC())
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        // Названия контроллеров (страниц) и иконки
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        nav1.navigationBar.prefersLargeTitles = false
        nav2.navigationBar.prefersLargeTitles = false
        
        setViewControllers([nav1, nav2], animated: false)
        
        UITabBar.appearance().backgroundColor = .white // Цвет фона TabBar'а
        UITabBar.appearance().tintColor = .black // Цвет иконок и текста
    }
    
}
