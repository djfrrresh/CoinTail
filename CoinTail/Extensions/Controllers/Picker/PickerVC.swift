//
//  PickerVC.swift
//  CoinTail
//
//  Created by Eugene on 01.12.23.
//

import UIKit


class PickerVC: BasicVC {
    
    var isPickerHidden: Bool = true
    
    let pickerToolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.isHidden = true
        toolbar.sizeToFit()
        toolbar.tintColor = .systemBlue
        toolbar.backgroundColor = .white
        toolbar.layer.zPosition = 1000

        return toolbar
    }()
        
    let itemsPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.isHidden = true
        picker.backgroundColor = .white
        picker.layer.zPosition = 1000
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerSubview()
    }
    
}
