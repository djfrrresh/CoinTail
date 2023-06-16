//
//  AddOperationUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


extension AddOperationVC {
    
    func setAddOpStack() {
        // AMOUNT
        let amountStack = UIStackView()
        setStack(
            stack: amountStack,
            axis: .vertical,
            spacing: 6,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [amountLabel, amountTextField]
        )
        
        // CATEGORY BUTTON && AMOUNT
        let categoryAmountStack = UIStackView()
        setStack(
            stack: categoryAmountStack,
            axis: .vertical,
            spacing: 16,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [amountStack, categoryButton]
        )
        
        // DESCRIPTION
        let descriptionStack = UIStackView()
        setStack(
            stack: descriptionStack,
            axis: .vertical,
            spacing: 6,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [descriptionLabel, descriptionTextField]
        )
        
        // DATE
        let dateStack = UIStackView()
        setStack(
            stack: dateStack,
            axis: .vertical,
            spacing: 6,
            alignment: .fill,
            distribution: .fill,
            viewsArray: [dateLabel, dateTextField]
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
                categoryAmountStack,
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
            viewsArray: [preFinalStack, saveButton]
        )
        
        view.addSubview(finalStack)
        finalStack.easy.layout([
            Left(16),
            Right(16),
            Top(10).to(self.view.safeAreaLayoutGuide, .top),
            Bottom(10).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
    }
    
    // Создание вертикального меню выше пикера времени с кнопками действия
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
    
    // Всплывающий алерт при ошибке
    func errorAlert(_ message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alertView.addAction(alertAction)
        self.present(alertView, animated: true)
    }
    
}
