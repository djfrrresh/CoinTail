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
    
    // Всплывающий алерт при ошибке
    func errorAlert(_ message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alertView.addAction(alertAction)
        self.present(alertView, animated: true)
    }
    
    func switchSegment() {
        categoryButton.setTitle(AddOperationVC.defaultCategory, for: .normal)
        
        let segment = addOperationTypeSwitcher.titleForSegment(at: addOperationTypeSwitcher.selectedSegmentIndex)
        
        addOperationSegment = RecordType(rawValue: segment ?? "") ?? .income
        
        // Добавление неудаляемого знака минуса в тип "траты"
        if addOperationSegment == .expense {
            if !amountTF.text!.hasPrefix("-") {
                amountTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: amountTF.frame.height))
                amountTF.leftViewMode = .always
                amountTF.text = "-" + amountTF.text!
            }
        } else { // Удаление минуса
            amountTF.text = amountTF.text?.replacingOccurrences(
                of: "-",
                with: ""
            )
        }
    }
    
}
