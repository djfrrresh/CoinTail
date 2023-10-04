//
//  KeyboardManager.swift
//  CoinTail
//
//  Created by Eugene on 04.10.23.
//

import UIKit


class KeyboardManager {
    
    static let shared = KeyboardManager()

    func startObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func stopObservingKeyboard() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        print("show")
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        print("hide")
    }
    
}
