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
        setTextField(textField: amountTextField, text: "Enter your value", background: .lightGray.withAlphaComponent(0.2), keyboard: .decimalPad, default_text: "0.00")
        setUniqueStack(stack: amountStack, view_1: amountLabel, view_2: amountTextField)
        
        // DESCRIPTION
        setLabel(label: descriptionLabel, text: "Description")
        setTextField(textField: descriptionTextField, text: "For example: Bought in the store", background: .clear, keyboard: .default, default_text: nil)
        setUniqueStack(stack: descriptionStack, view_1: descriptionLabel, view_2: descriptionTextField)
        
        // DATE
        setLabel(label: dateLabel, text: "Date")
//        setDatePickerTextField(textField: dateTextField, picker: datePicker)
        setDatePickerButton(button: dateButton, picker: datePicker)
//        setUniqueStack(stack: dateStack, view_1: dateLabel, view_2: dateTextField)
        setUniqueStack(stack: dateStack, view_1: dateLabel, view_2: dateButton)
        
        // CATEGORY
        setButton(button: categoryButton, text: "Select category", background: .clear, textColor: .black)
        
        // SAVE
        setButton(button: saveButton, text: "Save operation", background: .black, textColor: .white)

        // SWITCH
        setSwitchButton(switcher: switchButton)
        
        let categoryAmountStack = UIStackView()
        categoryAmountStack.axis = .vertical
        categoryAmountStack.spacing = 16
        categoryAmountStack.addArrangedSubview(amountStack)
        categoryAmountStack.addArrangedSubview(categoryButton)
                
        let preFinalStack = UIStackView()
        preFinalStack.axis = .vertical
        preFinalStack.spacing = 32
        preFinalStack.addArrangedSubview(switchButton)
        preFinalStack.addArrangedSubview(categoryAmountStack)
        preFinalStack.addArrangedSubview(descriptionStack)
        preFinalStack.addArrangedSubview(dateStack)
        
        let finalStack = UIStackView()
        finalStack.axis = .vertical
        finalStack.alignment = .fill // Выравнивание 
        finalStack.distribution = .equalCentering // Заполнение
        finalStack.spacing = 102
        finalStack.addArrangedSubview(preFinalStack)
        finalStack.addArrangedSubview(saveButton)
        view.addSubview(finalStack)
        finalStack.easy.layout([Left(16), Right(16), CenterY(), CenterX()])
    }
    
}
