//
//  AddNewOperationSetFuncs.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy


extension AddNewOperationVC {
    
    func setButton(button: UIButton, text: String, background: UIColor, textColor: UIColor) {
        button.layer.cornerRadius = 8
        button.setTitle(text, for: .normal)
        button.backgroundColor = background
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(textColor, for: .normal)
        button.layer.borderWidth = 1
        button.easy.layout([Height(54)])
    }
    
    func setTextField(textField: UITextField, text: String, background: UIColor) {
        textField.layer.cornerRadius = 8
        textField.autocorrectionType = .no
        textField.backgroundColor = background
        textField.placeholder = text
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.easy.layout([Height(54)])
    }
    
    func setLabel(label: UILabel, text: String) {
        label.text = text
        label.textAlignment = .left
    }
    
    func setDatePickerTextField(textField: UITextField, picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        textField.inputView = picker
        textField.layer.borderColor = UIColor.gray.cgColor
        let nowDate = dateFormatter.string(from: datePicker.date)
        textField.placeholder = "Today, \(nowDate)"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.easy.layout([Height(54)])
        textField.inputAccessoryView = createToolbar()
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
}
