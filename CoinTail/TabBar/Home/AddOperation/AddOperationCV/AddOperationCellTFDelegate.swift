//
//  AddOperationCellTFDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.11.23.
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
        guard let textViewString = textView.text, let textViewRange = Range(range, in: textViewString) else {
            return false
        }
        let allString = textViewString.replacingCharacters(in: textViewRange, with: text)
        let charactersCount = String(textViewString).count
        
        if textView.text == "Add a comment to your transaction".localized() || textView.text == "There is no description for the transaction".localized() {
            textView.text = ""
            textView.textColor = .black
        }
        
        addOperationCellDelegate?.cell(didUpdateOperationDescription: allString)
        
        // Эта проверка должна быть всегда ниже функции делегата, чтобы при удалении символа сохранялась данная строка
        guard !text.isEmpty else { return true }
                
        return charactersCount < 64
    }
    
}
