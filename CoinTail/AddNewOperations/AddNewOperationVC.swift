//
//  AddNewOperationVC.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy

// Указываем название протокола из AddNewOperationPopVC
class AddNewOperationVC: UIViewController, СategorySendText {
    // Вызываем функцию из протокола и делаем всякое
    func sendCategory(category: String) {
        categoryButton.setTitle(category, for: .normal) // Меняет текст выбранной категории в кнопке
    }
    
    // SWITCH
    let switchButton: UISegmentedControl = {
        let switcher = UISegmentedControl(items: ["Income", "Expense"])
        switcher.selectedSegmentIndex = 1
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
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.backgroundColor = .white.withAlphaComponent(1)
        self.title = "Add a new operation"

        self.navigationController?.navigationBar.tintColor = .black
        
        self.saveButton.addTarget(self,
                         action: #selector(saveButtonAction),
                         for: .touchUpInside)
        self.categoryButton.addTarget(self,
                         action: #selector(categoryButtonAction),
                         for: .touchUpInside)
        self.switchButton.addTarget(self,
                         action: #selector(switchButtonAction),
                         for: .valueChanged)
        
        setStack() // Стаки для объектов на экране
    }
    
}
