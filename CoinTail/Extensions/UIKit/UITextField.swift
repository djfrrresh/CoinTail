//
//  UITextField.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit
import EasyPeasy


class EmojiTextField: UITextField {

    override var textInputContextIdentifier: String? { "" }

    override var textInputMode: UITextInputMode? {
        if let emojiMode = UITextInputMode.activeInputModes.first(where: { $0.primaryLanguage == "emoji" }) {
            return emojiMode
        }
        return nil
    }
    
}
