//
//  HomeUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 18.05.23.
//

import UIKit
import EasyPeasy


extension HomeVC {
    
    func homeSubviews() {
        self.view.addSubview(homeTypeSwitcher)
        self.view.addSubview(balanceLabel)
        self.view.addSubview(globalCV)
        
        homeTypeSwitcher.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        balanceLabel.easy.layout([
            CenterX(),
            Top(-30).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        globalCV.easy.layout([
            Left(),
            Right(),
            Bottom(),
            Top(16).to(homeTypeSwitcher, .bottom)
        ])
    }
    
    // Кнопки "Добавить" и "Поиск" в навигейшен баре
    func homeNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (addNewOperationAction)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector (searchBarAction)
        )
    }

}
