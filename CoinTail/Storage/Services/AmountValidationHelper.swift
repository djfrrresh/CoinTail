//
//  AmountValidationHelper.swift
//  CoinTail
//
//  Created by Eugene on 04.10.23.
//

import UIKit


struct AmountValidationHelper {
    // range - размер строки, string - вводимое значение пользователем
    static func isValidInput(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Позволяет удалить символы в строке, если достигнута максимальная длина (8)
        guard !string.isEmpty else { return true }
        
        // Принимаемые значения для текстового поля Amount
        let allowedCharactersSet = CharacterSet(charactersIn: "1234567890")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        let allowedCharacters = allowedCharactersSet.isSuperset(of: typedCharacterSet)
        
        // Проверка на тип вводимого значения
        guard allowedCharactersSet.isSuperset(of: typedCharacterSet), let textFieldString = textField.text, let range = Range(range, in: textFieldString) else {
            return false
        }
        
        // Заменяет начальные нули в поле на вводимый текст
        if textField.text == "0" {
            textField.text = string
        }
        
        // Все введенные значения пользователем
        let allString = textFieldString.replacingCharacters(in: range, with: string)
        // Проверка на нули в начале строки
        if allString.starts(with: "0") { return false }
        
        // Количество цифр в строке
        let charactersCount = String(textFieldString).count
        
        // Возвращает допустимые значения для строки
        // Длину общей строки не более 8 символов
        return allowedCharacters && charactersCount <= 8
    }
}
