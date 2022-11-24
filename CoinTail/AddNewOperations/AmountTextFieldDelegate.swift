//
//  AmountTextFieldDelegate.swift
//  CoinTail
//
//  Created by Eugene on 01.11.22.
//

import UIKit


// В поле Amount подставляются только цифры и символ "."
extension AddNewOperationVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Принимаемые значения для текстового поля Amount
        let allowedCharactersSet = CharacterSet(charactersIn: ".123456790")
        let typedCharacterSet = CharacterSet(charactersIn: string)

        guard let textFieldString = textField.text, let range = Range(range, in: textFieldString) else {
            return false
        }

        let newString = textFieldString.replacingCharacters(in: range, with: string)
        let charactersCount = String(textFieldString).count
        let allowedCharacters = allowedCharactersSet.isSuperset(of: typedCharacterSet)
        
        let segment = switchButton.titleForSegment(at: switchButton.selectedSegmentIndex)
        
        var textString: String?
     
        switch segment {
        case "Expense":
            textString = "-0.00"
            break
        case "Income":
            textString = "0.00"
            break
        default: break
        }
        
        if newString.isEmpty {
            textField.text = textString
            return false
        } else if textField.text == textString {
            textField.text = string
            return false
        }
        else if textField.text == "0" {
            textField.text = string
            return false
        }
        // Позволяет ставить не более 1 точки
        if string == "." {
            let countdots = textField.text!.components(separatedBy:".").count - 1
            if countdots == 0 {
                return true
            } else {
                if countdots > 0 && string == "." {
                    return false
                } else {
                    return true
                }
            }
        }
        
        // Возвращает допустимые значения и длину строки не более 8 символов
        return allowedCharacters && charactersCount <= 8
    }
}
