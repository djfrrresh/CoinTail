//
//  AddAccountTFDelegate.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AddAccountVC {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == accountAmountTF {
            return AmountValidationHelper.isValidInput(textField, shouldChangeCharactersIn: range, replacementString: string)
        } else {
            return true
        }
    }

}
