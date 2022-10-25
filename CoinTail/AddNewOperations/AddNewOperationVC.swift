//
//  AddNewOperationVC.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy


class AddNewOperationVC: UIViewController {
    
    // SWITCH
    let switchButton: UISegmentedControl = {
        let switcher = UISegmentedControl(items: ["Income", "Expense"])
        return switcher
    }()
    
    // LABELS
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
    
    // TEXTFIELDS
    let amountTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    let dateTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    // BUTTONS
    let categoryButton: UIButton = {
        let button = UIButton()
        return button
    }()
    let saveButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // DATE
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.timeZone = NSTimeZone.local
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    @objc func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white.withAlphaComponent(1)
        self.title = "Add a new operation"

        self.navigationController?.navigationBar.tintColor = .black
        
        setStack()
    }
    
}
