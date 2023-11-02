//
//  AddAccountPicker.swift
//  CoinTail
//
//  Created by Eugene on 31.10.23.
//

import UIKit


extension AddAccountVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
        
        let indexPathToUpdate = IndexPath(item: 2, section: 0)
        updateCell(at: indexPathToUpdate)
    }
    
}
