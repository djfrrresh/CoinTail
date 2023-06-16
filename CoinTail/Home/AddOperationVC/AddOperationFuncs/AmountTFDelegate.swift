//
//  AmountTFDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


// В поле Amount подставляются только цифры и символ "."
extension AddOperationVC: UITextFieldDelegate {
    
    // range - размер строки, string - вводимое значение пользователем
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Позволяет не писать символы в текстовое поле с датой
        guard textField != dateTextField else { return false }
        
        // Позволяет удалить символы в строке, если достигнута максимальная длина (8)
        guard !string.isEmpty else { return true }
        
        // Принимаемые значения для текстового поля Amount
        let allowedCharactersSet = CharacterSet(charactersIn: ".1234567890")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        let allowedCharacters = allowedCharactersSet.isSuperset(of: typedCharacterSet)
        
        // Проверка на тип вводимого значения
        guard allowedCharactersSet.isSuperset(of: typedCharacterSet), let textFieldString = textField.text, let range = Range(range, in: textFieldString) else {
            return false
        }
        
        // Заменяет начальные нули в поле на вводимый текст
        if textField.text == "0.00" || textField.text == "-0.00" {
            textField.text = addOperationSegment == .income ? string : "-\(string)"
        }
        
        // Все введенные значения пользователем
        let allString = textFieldString.replacingCharacters(in: range, with: string)
        // Проверка на точку в начале строки
        if (allString.starts(with: ".")) { return false }
        
        // Количество цифр в строке
        let charactersCount = String(textFieldString).count

        // Возвращает допустимые значения для строки (цифры и точку)
        // Длину общей строки не более 8 символов
        // Длину строки после запятой
        // Количество точек
        return maxNumAfterComma(textFieldString: textFieldString) && maxDots(textFieldString: textFieldString, string: string) && allowedCharacters && charactersCount <= 8
    }
    
    // Позволять не удалять минус из поля Amount
    @objc func textFieldDidChange(_ textField: UITextField) {
        if addOperationSegment == .expense {
            if !textField.text!.starts(with: "-") {
                textField.text = "-" + textField.text!
            }
        }
    }
        
    // Позволяет ставить не более 1 точки
    private func maxDots(textFieldString: String, string: String) -> Bool {
        if string == "." {
            let countDots = textFieldString.components(separatedBy:".").count - 1

            if countDots == 0 {
                return true
            } else if countDots > 0 && string == "." {
                return false
            }
        }
        return true
    }
    
    // Позволяет ввести не более 2 цифр после точки
    private func maxNumAfterComma(textFieldString: String) -> Bool {
        let amountFormatter = NumberFormatter()
        amountFormatter.maximumFractionDigits = 2
        amountFormatter.roundingMode = .up
        
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
