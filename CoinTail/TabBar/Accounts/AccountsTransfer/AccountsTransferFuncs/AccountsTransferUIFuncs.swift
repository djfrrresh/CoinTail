//
//  AccountsTransferUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 06.09.23.
//

import UIKit
import EasyPeasy


extension AccountsTransferVC {
    
    func transferSubviews() {
        self.view.addSubview(selectFirstAccountButton)
        self.view.addSubview(transferAmountLabel)
        self.view.addSubview(transferAmountTF)
        self.view.addSubview(arrowImage)
        self.view.addSubview(selectSecondAccountButton)
        self.view.addSubview(saveTransferButton)
        
        selectFirstAccountButton.easy.layout([
            Left(16),
            Right(16),
            Height(40),
            Top(40).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        transferAmountLabel.easy.layout([
            CenterX(),
            Top(16).to(selectFirstAccountButton, .bottom)
        ])
        
        transferAmountTF.easy.layout([
            CenterX(),
            Left(16),
            Right(16),
            Top(8).to(transferAmountLabel, .bottom)
        ])
        
        arrowImage.easy.layout([
            Height(28),
            Width(28),
            CenterX(),
            Top(20).to(transferAmountTF, .bottom)
        ])
        
        selectSecondAccountButton.easy.layout([
            Left(16),
            Right(16),
            Height(40),
            Top(16).to(arrowImage, .bottom)
        ])
        
        saveTransferButton.easy.layout([
            Left(16),
            Right(16),
            Bottom(20).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
    }
    
    func addTransparentView(button: UIButton) {
        self.view.addSubview(transparentView)
        transparentView.easy.layout(Edges())
        
        self.view.addSubview(accountsCV)
        accountsCV.easy.layout([
            Left(16),
            Right(16),
            Height(60),
            Top().to(button, .bottom)
        ])

        accountsCV.reloadData()
        selectedButton = button
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: { [self] in
                transparentView.alpha = 0.5
            
                accountsCV.easy.layout([
                    Height(CGFloat(60 * accountsArr.count + (8 * accountsArr.count - 1)))
                ])
        },  completion: nil)
    }
    
}
