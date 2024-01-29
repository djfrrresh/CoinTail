//
//  BasicAlertFuncs.swift
//  CoinTail
//
//  Created by Eugene on 22.01.24.
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
import EasyPeasy


extension BasicVC {
    
    // TODO: переделать алерты под enum по примеру ниже
//    enum AlertError: Error {
//        case noName
//        case noPassword
//        case wrongUserData
//    }
    
    // Всплывающий алерт с информацией
    func infoAlert(_ message: String, _ title: String = "Error") {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        let alertView = UIAlertController(title: title.localized(), message: message, preferredStyle: .alert)
        
        alertView.addAction(alertAction)
        
        self.present(alertView, animated: true)
    }
    
    // Алерт с подтверждением действия
    func confirmationAlert(title: String, message: String, confirmActionTitle: String, confirmActionHandler: @escaping () -> Void) {
        let confirmAction = UIAlertAction(title: confirmActionTitle, style: .default) { _ in
            confirmActionHandler()
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertView.addAction(confirmAction)
        alertView.addAction(cancelAction)
        
        self.present(alertView, animated: true)
    }
    
}
