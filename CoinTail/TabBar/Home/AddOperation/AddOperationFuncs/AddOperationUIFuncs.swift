//
//  AddOperationUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


extension AddOperationVC {
    
    func addOperationNavBar() {
        let barButton = UIBarButtonItem(
            image: UIImage(systemName: "dollarsign.arrow.circlepath"),
            style: .done,
            target: self,
            action: #selector(repeatOperationAction)
        )
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func setAddOpStack() {
        // AMOUNT
        let amountStack = UIStackView()
        setStack(
            stack: amountStack,
            axis: .vertical,
            spacing: 6,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [amountLabel, amountTF]
        )
        
        // CATEGORY BUTTON && AMOUNT
        let amountCategoryAccountStack = UIStackView()
        setStack(
            stack: amountCategoryAccountStack,
            axis: .vertical,
            spacing: 16,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [amountStack, categoryButton, accountButton]
        )
        
        // DESCRIPTION
        let descriptionStack = UIStackView()
        setStack(
            stack: descriptionStack,
            axis: .vertical,
            spacing: 6,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [descriptionLabel, descriptionTF]
        )
        
        // DATE
        let dateStack = UIStackView()
        setStack(
            stack: dateStack,
            axis: .vertical,
            spacing: 6,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [dateLabel, dateTF]
        )
                
        let preFinalStack = UIStackView()
        setStack(
            stack: preFinalStack,
            axis: .vertical,
            spacing: 32,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [
                addOperationTypeSwitcher,
                amountCategoryAccountStack,
                descriptionStack,
                dateStack
            ]
        )
        
        let finalStack = UIStackView()
        setStack(
            stack: finalStack,
            axis: .vertical,
            spacing: 70,
            alignment: .fill,
            distribution: .equalCentering,
            viewsArray: [preFinalStack, saveOperationButton]
        )
        
        self.view.addSubview(finalStack)
        finalStack.easy.layout([
            Left(16),
            Right(16),
            Top(10).to(self.view.safeAreaLayoutGuide, .top),
            Bottom(10).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
    }
    
    // Создание меню выше пикера времени с кнопками действия
    static func createToolbar() -> UIToolbar { // Всплывающий снизу DatePicker
        let toolbar: UIToolbar = {
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            toolBar.tintColor = .systemBlue
            
            let doneButton = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: nil,
                action: #selector(doneButtonAction)
            )
            toolBar.setItems([doneButton], animated: true)
            
            return toolBar
        }()

        return toolbar
    }
    
}
