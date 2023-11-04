//
//  SelectCategoryUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.11.23.
//

import UIKit
import EasyPeasy


extension SelectCategoryVC {
    
    func selectCategorySubviews() {
        self.view.addSubview(newCategoryButton)
        self.view.addSubview(selectCategoryCV)
        self.view.addSubview(categorySearchBar)
        
        categorySearchBar.easy.layout([
            Left(16),
            Right(16),
            Height(36),
            CenterX(),
            Top(16).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        newCategoryButton.easy.layout([
            Bottom(20).to(self.view.safeAreaLayoutGuide, .bottom),
            Right(20).to(self.view.safeAreaLayoutGuide, .right),
            Height(64),
            Width(64)
        ])
        
        selectCategoryCV.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top(24).to(categorySearchBar, .bottom),
            Bottom(16).to(newCategoryButton, .top)
        ])
    }
    
}
