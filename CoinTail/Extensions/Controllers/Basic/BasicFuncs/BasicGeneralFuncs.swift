//
//  BasicGeneralFuncs.swift.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
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
    
    // Настройка title для контроллера
    func setupNavigationTitle(title: String, large: Bool = false) {
        prefersLargeTitle = large
        navigationController?.navigationBar.prefersLargeTitles = large
        navigationItem.largeTitleDisplayMode = large ? .always : .never
        
        if large {
            navigationItem.title = title
            navigationItem.setValue(1, forKey: "__largeTitleTwoLineMode")
            
            
        } else {
            let titleLabel: UILabel = {
                let label = UILabel()
                label.text = title
                label.textAlignment = .center
                label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
                
                return label
            }()
            
            navigationItem.titleView = titleLabel
        }
    }
    
    // Убрать клавиатуру при нажатии на экран за пределы клавиатуры
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(endEditingRecognizer())
        navigationController?.navigationBar.addGestureRecognizer(endEditingRecognizer())
    }
    // Регистрирует нажатия на экран
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        
        return tap
    }
    
}

extension BasicVC: UITextFieldDelegate {
    
    // Обработка нажатия Return на клавиатуре
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Закрыть клавиатуру
        
        return true
    }
    
}
