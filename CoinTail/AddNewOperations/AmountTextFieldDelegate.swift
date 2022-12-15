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
        guard !string.isEmpty else { return true }
        // Принимаемые значения для текстового поля Amount
        let allowedCharactersSet = CharacterSet(charactersIn: ".123456790")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        let allowedCharacters = allowedCharactersSet.isSuperset(of: typedCharacterSet)
        
        // Проверка на тип вводимого значения
        guard allowedCharactersSet.isSuperset(of: typedCharacterSet), let textFieldString = textField.text, let range = Range(range, in: textFieldString) else {
            return false
        }

        let newString = textFieldString.replacingCharacters(in: range, with: string)
        
        let charactersCount = String(textFieldString).count
            
        let segment = switchButton.titleForSegment(at: switchButton.selectedSegmentIndex)!
        let type = RecordType(rawValue: segment)!
        var textString: String?
     
        textString = "0.0"
        
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

        // Возвращает допустимые значения для строки
        // Длину общей строки не более 8 символов
        // Длину строки после запятой
        // Количество точек
        return maxNumAfterComma(textFieldString: textFieldString) && maxDots(textFieldString: textFieldString, string: string) && allowedCharacters && charactersCount <= 8
    }
    
    // Позволяет ставить не более 1 точки
    func maxDots(textFieldString: String, string: String) -> Bool {
        if string == "." {
            let countdots = textFieldString.components(separatedBy:".").count - 1

            if countdots == 0 {
                return true
            } else {
                if countdots > 0 && string == "." {
                    return false
                }
            }
        }
        return true
    }
    
    // Позволяет ввести не более 2 цифр после точки
    func maxNumAfterComma(textFieldString: String) -> Bool {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .up
        
        let floatSplit = textFieldString.split(separator: ".")

        if floatSplit.count > 1 {
            let numAfterComma = floatSplit[1]
            if numAfterComma.count > 1 {
                return false
            }
        }
        return true
    }
}
