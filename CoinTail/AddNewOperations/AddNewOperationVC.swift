//
//  AddNewOperationVC.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy


class AddNewOperationVC: UIViewController {
    
    let switchButton: UISegmentedControl = {
        let switcher = UISegmentedControl(items: ["Income", "Expense"])
        return switcher
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let categoryButton: UIButton = {
        let button = UIButton()
        return button
    }()
    let saveButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white.withAlphaComponent(0.9)
        self.title = "Add a new operation"

        self.navigationController?.navigationBar.tintColor = .black
    }
    
}
