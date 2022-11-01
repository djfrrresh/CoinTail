//
//  AmountTextFieldDelegate.swift
//  CoinTail
//
//  Created by Eugene on 01.11.22.
//

import UIKit


// В поле Amount подставляются только цифры и символы ". ,"
extension AddNewOperationVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharactersSet = CharacterSet(charactersIn: ",.123456790")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        guard let textFieldString = textField.text, let range = Range(range, in: textFieldString) else {
            return false
        }
        let newString = textFieldString.replacingCharacters(in: range, with: string)
        if newString.isEmpty {
            textField.text = "0.00"
            return false
        } else if textField.text == "0.00" {
            textField.text = string
            return false
        }
        
        return allowedCharactersSet.isSuperset(of: typedCharacterSet)
    }
    
}
