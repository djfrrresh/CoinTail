//
//  PickerFuncs.swift
//  CoinTail
//
//  Created by Eugene on 01.12.23.
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


extension PickerVC {
    
    func pickerSubview() {
        self.view.addSubview(itemsPickerView)
        self.view.addSubview(pickerToolBar)
        
        itemsPickerView.easy.layout([
            Left(),
            Right(),
            Height(200),
            Bottom(-300).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
        
        pickerToolBar.easy.layout([
            Left(),
            Right(),
            Height(44),
            Bottom().to(itemsPickerView, .top)
        ])
    }
    
    func setupToolBar() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonAction)
        )

        pickerToolBar.setItems([doneButton], animated: true)
    }
    
    @objc func doneButtonAction() {
        hidePickerView()
    }
    
    func showPickerView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.itemsPickerView.isHidden = false
            strongSelf.pickerToolBar.isHidden = false
            strongSelf.itemsPickerView.easy.layout(
                Bottom()
            )
            strongSelf.view.layoutIfNeeded()
        }
        isPickerHidden = false
    }
    
    func hidePickerView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.itemsPickerView.easy.layout(
                Bottom(-300).to(strongSelf.view.safeAreaLayoutGuide, .bottom)
            )
            strongSelf.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.itemsPickerView.isHidden = true
            self?.pickerToolBar.isHidden = true
        }
        isPickerHidden = true
    }
    
}
