//
//  AddNewOperationStacks.swift
//  CoinTail
//
//  Created by Eugene on 25.10.22.
//

import UIKit
import EasyPeasy


extension AddNewOperationVC {
    
    func setStack() {
        
        let amountStack = UIStackView()
        let descriptionStack = UIStackView()
        let dateStack = UIStackView()
        
        // AMOUNT
        setLabel(label: amountLabel, text: "Amount")
        setTextField(textField: amountTextField, text: "Enter your value", background: .lightGray.withAlphaComponent(0.2))
        setUniqueStack(stack: amountStack, view_1: amountLabel, view_2: amountTextField)
        
        // DESCRIPTION
        setLabel(label: descriptionLabel, text: "Description")
        setTextField(textField: descriptionTextField, text: "For example: Bought in the store", background: .clear)
        setUniqueStack(stack: descriptionStack, view_1: descriptionLabel, view_2: descriptionTextField)
        
        // DATE
        setLabel(label: dateLabel, text: "Date")
        setDatePickerTextField(textField: dateTextField, picker: datePicker)
        setUniqueStack(stack: dateStack, view_1: dateLabel, view_2: dateTextField)
        
        // CATEGORY
        setButton(button: categoryButton, text: "Select category", background: .clear, textColor: .black)
        
        // SAVE
        setButton(button: saveButton, text: "Save operation", background: .black, textColor: .white)

        
        let categoryAmountStack = UIStackView()
        categoryAmountStack.axis = .vertical
        categoryAmountStack.spacing = 16
        categoryAmountStack.addArrangedSubview(amountStack)
        categoryAmountStack.addArrangedSubview(categoryButton)
                
        let preFinalStack = UIStackView()
        preFinalStack.axis = .vertical
        preFinalStack.distribution = .equalCentering
        preFinalStack.spacing = 32
        preFinalStack.alignment = .fill
        preFinalStack.addArrangedSubview(switchButton)
        preFinalStack.addArrangedSubview(categoryAmountStack)
        preFinalStack.addArrangedSubview(descriptionStack)
        preFinalStack.addArrangedSubview(dateStack)
        
        let finalStack = UIStackView()
        finalStack.axis = .vertical
        finalStack.spacing = 50
        finalStack.addArrangedSubview(preFinalStack)
        finalStack.addArrangedSubview(saveButton)
        view.addSubview(finalStack)
        finalStack.easy.layout([Left(16), Right(16), CenterY(), CenterX()])
    }
    
}
