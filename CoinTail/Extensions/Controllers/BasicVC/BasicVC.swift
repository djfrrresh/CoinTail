//
//  BasicVC.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit


class BasicVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Убрать клавиатуру при нажатии на экран
        setupHideKeyboardOnTap()
        
        self.view.backgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .black
    }
    
}
