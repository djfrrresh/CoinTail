//
//  AddAccountUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit
import EasyPeasy


extension AddAccountVC {
    
    func setAddAccountStack() {
        let amountStack = UIStackView()
        setStack(
            stack: amountStack,
            axis: .vertical,
            spacing: 6,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [accountAmountLabel, accountAmountTF]
        )
        
        let nameStack = UIStackView()
        setStack(
            stack: nameStack,
            axis: .vertical,
            spacing: 6,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [accountNameLabel, accountNameTF]
        )
        
        let amountNameStack = UIStackView()
        setStack(
            stack: amountNameStack,
            axis: .vertical,
            spacing: 16,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [amountStack, nameStack]
        )
        
        let finalStack = UIStackView()
        setStack(
            stack: finalStack,
            axis: .vertical,
            spacing: 70,
            alignment: .fill,
            distribution: .equalCentering,
            viewsArray: [amountNameStack, saveAccountButton]
        )
        
        self.view.addSubview(finalStack)
        finalStack.easy.layout([
            Left(16),
            Right(16),
            Top(10).to(self.view.safeAreaLayoutGuide, .top),
            Bottom(10).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
        
        self.view.addSubview(currencyButton)
        currencyButton.easy.layout([
            Right(8).to(accountAmountTF, .right),
            Height(32),
            Width(48),
            CenterY().to(accountAmountTF)
        ])
    }
    
}
