//
//  AddAccountCellTFDelegate.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit


extension AddAccountCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldString = textField.text, let textFieldRange = Range(range, in: textFieldString) else {
            return false
        }
        let allString = textFieldString.replacingCharacters(in: textFieldRange, with: string)
        let charactersCount = String(textFieldString).count
        
        if textField == accountAmountTF {
            addAccountCellDelegate?.cell(didUpdateAccountAmount: allString)

            return AmountValidationHelper.isValidInput(textField, shouldChangeCharactersIn: range, replacementString: string)
        } else {
            addAccountCellDelegate?.cell(didUpdateAccountName: allString)

            guard !string.isEmpty else { return true }

            return charactersCount < 24
        }
    }
    
}
