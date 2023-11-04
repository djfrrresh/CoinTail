//
//  AddBudgetPicker.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit


extension AddBudgetVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //TODO: первый элемент не выбирается из пикера если его сохранить
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return favouriteStringCurrencies.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return favouriteStringCurrencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = favouriteStringCurrencies[row]
    }
    
}
