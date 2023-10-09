//
//  AccountsTransferTFDelegate.swift
//  CoinTail
//
//  Created by Eugene on 07.09.23.
//

import UIKit


extension AccountsTransferVC {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        AmountValidationHelper.isValidInput(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
        
}
