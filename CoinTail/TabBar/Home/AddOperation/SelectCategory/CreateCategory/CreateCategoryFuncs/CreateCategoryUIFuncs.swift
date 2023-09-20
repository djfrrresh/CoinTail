//
//  CreateCategoryUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


extension CreateCategoryVC {

    func setPopupElements() {
        self.view.addSubview(popUpView)
        popUpView.addSubview(titleLabel)
        popUpView.addSubview(categoryTF)
        popUpView.addSubview(errorLabel)
        popUpView.addSubview(addButton)
        popUpView.addSubview(createCategoryCV)
        popUpView.addSubview(selectColorButton)
        popUpView.addSubview(parentalCategoryButton)
        
        popUpView.easy.layout([
            Center(),
            Left(20),
            Right(20),
            Height(380)
        ])
        
        titleLabel.easy.layout([
            CenterX(),
            Top(10)
        ])
        
        categoryTF.easy.layout([
            Top(10).to(titleLabel, .bottom),
            Height(40),
            Left(20),
            Right(20)
        ])
        
        createCategoryCV.easy.layout([
            Height(50),
            Left(),
            Right(),
            Top(10).to(categoryTF, .bottom)
        ])
        
        selectColorButton.easy.layout([
            Top(16).to(createCategoryCV, .bottom),
            CenterX(),
            Left(16),
            Right(16)
        ])
        
        errorLabel.easy.layout([
            Top(20).to(addButton, .bottom),
            CenterX()
        ])
        
        parentalCategoryButton.easy.layout([
            Top(16).to(selectColorButton, .bottom),
            CenterX(),
            Left(16),
            Right(16)
        ])

        addButton.easy.layout([
            Top(16).to(parentalCategoryButton, .bottom),
            CenterX(),
            Left(16),
            Right(16)
        ])
            
    }
    
    // Анимация вывода ошибки
    func errorAnimate() {
        if categoryTF.text?.isEmpty == true {
            UIView.animate(withDuration: 0.1) { [self] in
                errorLabel.isHidden = false
                errorLabel.alpha = 1

                popUpView.easy.layout([Height(420)])
                
                view.layoutIfNeeded()
            }
        }
    }
    
}
