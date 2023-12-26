//
//  CreateCategoryCellTFDelegate.swift
//  CoinTail
//
//  Created by Eugene on 14.11.23.
//

import UIKit


extension CreateCategoryCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }

        guard let textFieldString = textField.text, let textFieldRange = Range(range, in: textFieldString) else {
            return false
        }
        let allString = textFieldString.replacingCharacters(in: textFieldRange, with: string)
        let charactersCount = String(textFieldString).count
        
        if textField == categoryNameTF {
            createCategoryCellDelegate?.cell(didUpdateCategoryName: allString)
            
            return charactersCount < 24
        } else {
            createCategoryCellDelegate?.cell(didUpdateCategoryIcon: allString)
            
            return charactersCount < 1 && allString.containsEmoji
        }
    }
    
}
