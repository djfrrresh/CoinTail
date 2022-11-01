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
        button.layer.borderWidth = 1
        
        button.backgroundColor = background
        button.layer.borderColor = UIColor.black.cgColor
        
        button.setTitleColor(textColor, for: .normal)
        button.setTitle(text, for: .normal)
        
        button.easy.layout([Height(56)])
    }
    
    func setDatePickerButton(button: UIButton, picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let nowDate = dateFormatter.string(from: datePicker.date)
        
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .systemBackground
        
        button.setTitle("Today, \(nowDate)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.easy.layout([Height(56)])
    }
    
    func setTextField(textField: UITextField, text: String, background: UIColor, keyboard: UIKeyboardType, default_text: String?) {
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        
        textField.autocorrectionType = .no
        textField.backgroundColor = background
        textField.keyboardType = keyboard
        textField.placeholder = text
        textField.text = default_text
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.easy.layout([Height(56)])
    }
    
    func setSwitchButton(switcher: UISegmentedControl) {
        switcher.layer.cornerRadius = 8
        switcher.easy.layout([Height(32)])
    }
    
    func setLabel(label: UILabel, text: String) {
        label.text = text
        label.textAlignment = .left
    }
    
//    func setDatePickerTextField(textField: UITextField, picker: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//
//        textField.inputView = picker
//        textField.layer.borderColor = UIColor.gray.cgColor
//        let nowDate = dateFormatter.string(from: datePicker.date)
//        textField.placeholder = "Today, \(nowDate)"
//        textField.layer.cornerRadius = 8
//        textField.layer.borderWidth = 1
//        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
//        textField.leftViewMode = .always
//        textField.easy.layout([Height(56)])
//        textField.inputAccessoryView = createToolbar()
//    }
//
//    func createToolbar() -> UIToolbar { // Всплывающий снизу DatePicker
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
//        toolbar.setItems([doneButton], animated: true)
//
//        return toolbar
//    }
    
}
