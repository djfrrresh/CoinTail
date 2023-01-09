//
//  SettingsFuncs.swift
//  CoinTail
//
//  Created by Eugene on 27.12.22.
//

import UIKit
import EasyPeasy


extension SettingsViewController: sendSelectedCurrency {
    
    // Настройки для кнопки
    func setButton(button: UIButton, background: UIColor, textColor: UIColor) {
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        
        button.backgroundColor = background
        button.layer.borderColor = UIColor.black.cgColor
        
        button.setTitleColor(textColor, for: .normal)
                
        button.easy.layout([Height(56)])
    }
    
    func setLabel(label: UILabel, text: String) {
        label.text = text
        label.textAlignment = .left
    }
    
    // Создание стака между двумя элементами
    func setUniqueStack(stack: UIStackView, view_1: UIView, view_2: UIView?) {
        stack.axis = .vertical
        stack.spacing = 6
        stack.addArrangedSubview(view_1)
        stack.addArrangedSubview(view_2!)
    }
    
    func sendCurrency(currency: String) {
        changeCurrencyButton.setTitle(currency, for: .normal)
    }
    
}
