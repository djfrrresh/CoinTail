//
//  PickerFuncs.swift
//  CoinTail
//
//  Created by Eugene on 01.12.23.
//

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
