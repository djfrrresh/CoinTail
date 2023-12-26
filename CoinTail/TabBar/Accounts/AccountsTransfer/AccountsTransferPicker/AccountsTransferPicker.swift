//
//  AccountsTransferPicker.swift
//  CoinTail
//
//  Created by Eugene on 30.10.23.
//

import UIKit


extension AccountsTransferVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accountNames.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return accountNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch selectedRowIndex {
        case 0:
            accountNameFrom = accountNames[row]
        case 1:
            accountNameTo = accountNames[row]
        default:
            return
        }
    }
    
}
