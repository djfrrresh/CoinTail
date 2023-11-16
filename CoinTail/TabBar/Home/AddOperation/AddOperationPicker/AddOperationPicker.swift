//
//  AddOperationPicker.swift
//  CoinTail
//
//  Created by Eugene on 16.11.23.
//

import UIKit


extension AddOperationVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return isUsingCurrenciesPicker ? favouriteStringCurrencies.count : accountNames.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return isUsingCurrenciesPicker ? favouriteStringCurrencies[row] : accountNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isUsingCurrenciesPicker {
            selectedCurrency = favouriteStringCurrencies[row]
        } else {
            selectedAccount = accountNames[row]
        }
    }
    
}
