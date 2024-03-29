//
//  TabBar.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit


class TabBar: UITabBarController {
    
    private let homeVC = UINavigationController(rootViewController: HomeVC())
    private let budgetsVC = UINavigationController(rootViewController: BudgetsVC())
    private let accountsVC = UINavigationController(rootViewController: AccountsVC())
    private let settingsVC = UINavigationController(rootViewController: SettingsVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        // Установка контроллеров на TabBar
        self.setViewControllers([homeVC, budgetsVC, accountsVC, settingsVC], animated: false)
        
        setAppearance()
    }
    
    private func setAppearance() {
        homeVC.title = "Home".localized()
        budgetsVC.title = "Budgets".localized()
        accountsVC.title = "Accounts".localized()
        settingsVC.title = "Settings".localized()
        
        UITabBar.appearance().backgroundColor = UIColor(named: "TabBarBackground") // Цвет фона TabBar'а
        UITabBar.appearance().tintColor = UIColor(named: "primaryAction") // Цвет выбранной иконки и текста
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "unselectedScreen") // Цвет невыбранных иконок
        
        guard let items = self.tabBar.items else { return }
        let images = ["house.fill", "chart.bar.xaxis", "creditcard.fill", "gearshape.fill"]
        
        // Установка иконок
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
    }
    
}
