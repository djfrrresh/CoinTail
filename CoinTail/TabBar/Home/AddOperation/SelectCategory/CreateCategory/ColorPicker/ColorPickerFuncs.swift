//
//  ColorPickerFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension CreateCategoryVC: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        
        selectedColor = color
        createCategoryCV.reloadData()
    }
    
}
