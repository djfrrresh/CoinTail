//
//  BasicVC.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit


class BasicVC: UIViewController {
    
    var prefersLargeTitle: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Убрать клавиатуру при нажатии на экран
        setupHideKeyboardOnTap()
        
        self.view.backgroundColor = UIColor(named: "AccentColor")
        self.navigationController?.navigationBar.tintColor = .black
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
