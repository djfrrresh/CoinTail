//
//  AddAccountCellTFDelegate.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit


extension AddAccountCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldString = textField.text, let textFieldRange = Range(range, in: textFieldString) else {
            return false
        }
        let allString = textFieldString.replacingCharacters(in: textFieldRange, with: string)

        addAccountDelegate?.textFieldIsEmpty(
            amountIsEmpty: accountAmountTF.text == "",
            nameIsEmpty: accountNameTF.text == ""
        )
        
        if textField == accountAmountTF {
            addAccountCellDelegate?.cell(didUpdateAccountAmount: allString)

            return AmountValidationHelper.isValidInput(textField, shouldChangeCharactersIn: range, replacementString: string)
        } else {
            addAccountCellDelegate?.cell(didUpdateAccountName: allString)

            return true
        }
    }
    
}
