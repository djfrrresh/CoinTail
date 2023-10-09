//
//  AboutAppUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 06.10.23.
//

import UIKit
import EasyPeasy


extension AboutAppVC {
    
    func setPopupElements() {
        self.view.addSubview(popUpView)
        popUpView.addSubview(aboutLabel)
        popUpView.addSubview(connectionLabel)
        popUpView.addSubview(telegramButton)
        popUpView.addSubview(gmailButton)

        popUpView.easy.layout([
            Center(),
            Left(20),
            Right(20),
            Height(220)
        ])
        
        aboutLabel.easy.layout([
            CenterX(),
            Top(16),
            Left(16),
            Right(16)
        ])
        
        connectionLabel.easy.layout([
            CenterX(),
            Bottom(16),
            Left(16),
            Right(16)
        ])
        
        telegramButton.easy.layout([
            Height(60),
            Width(60),
            CenterX(80),
            Bottom(12).to(connectionLabel, .top)
        ])
        
        gmailButton.easy.layout([
            Height(60),
            Width(60),
            CenterX(-80),
            Bottom(12).to(connectionLabel, .top)
        ])
    }
    
}
