//
//  AmountTFDelegate.swift
//  CoinTail
//
//  Created by Eugene on 05.07.23.
//

import UIKit


extension AddBudgetVC: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        AmountValidationHelper.isValidInput(textField, shouldChangeCharactersIn: range, replacementString: string)
    }

}
