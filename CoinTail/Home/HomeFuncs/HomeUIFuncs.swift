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
        self.view.addSubview(typeSwitcher)
        self.view.addSubview(balanceLabel)
        self.view.addSubview(globalCV)
        
        typeSwitcher.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        balanceLabel.easy.layout([
            Top(-30).to(self.view.safeAreaLayoutGuide, .top),
            CenterX()
        ])
        
        globalCV.easy.layout([
            Left(0),
            Right(0),
            Top(16).to(typeSwitcher, .bottom),
            Bottom()
        ])
    }
    
    // Кнопки "Добавить" и "Поиск" в навигейшен баре
    func homeNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (addNewOperationAction)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector (searchBarAction)
        )
    }

}
