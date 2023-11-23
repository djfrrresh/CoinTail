//
//  AddOperationCellTFDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.11.23.
//

import UIKit


extension AddOperationCell: UITextFieldDelegate, UITextViewDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {        
        guard let textFieldString = textField.text, let textFieldRange = Range(range, in: textFieldString) else {
            return false
        }
        let allString = textFieldString.replacingCharacters(in: textFieldRange, with: string)
        
        if textField == operationAmountTF {
            addOperationCellDelegate?.cell(didUpdateOperationAmount: allString)

            return AmountValidationHelper.isValidInput(textField, shouldChangeCharactersIn: range, replacementString: string)
        } else {
            return true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard !text.isEmpty else { return true }

        guard let textViewString = textView.text, let textViewRange = Range(range, in: textViewString) else {
            return false
        }
        let allString = textViewString.replacingCharacters(in: textViewRange, with: text)
        let charactersCount = String(textViewString).count
        
        if textView.text == "Add a comment to your transaction".localized() {
            textView.text = ""
            textView.textColor = UIColor(named: "black")
        }
        
        addOperationCellDelegate?.cell(didUpdateOperationDescription: allString)
                
        return charactersCount < 64
    }
    
}
