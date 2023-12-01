//
//  AddAccountPicker.swift
//  CoinTail
//
//  Created by Eugene on 31.10.23.
//

import UIKit


extension AddAccountVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AddAccountVC.favouriteStringCurrencies.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AddAccountVC.favouriteStringCurrencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = AddAccountVC.favouriteStringCurrencies[row]
    }
    
}
