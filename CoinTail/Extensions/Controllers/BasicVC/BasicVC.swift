//
//  BasicVC.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit


class BasicVC: UIViewController {
    
    var prefersLargeTitle: Bool = false
    
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
        
        // Убрать клавиатуру при нажатии на экран
        setupHideKeyboardOnTap()
        
        pickerSubview()
        
        self.view.backgroundColor = UIColor(named: "AccentColor")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "black")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitle
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.sizeToFit()

        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        super.viewWillDisappear(animated)
    }
    
}
