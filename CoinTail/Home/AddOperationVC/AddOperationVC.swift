//
//  AddOperationVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


class AddOperationVC: BasicVC {
    
    var operationID: Int?

    // TODO: deleted ->
    var recordID = 6
    
    let addOperationTypeSwitcher: UISegmentedControl = {
        let switcher = UISegmentedControl(items: [
            RecordType.income.rawValue,
            RecordType.expense.rawValue
        ])
        return switcher
    }()
    var addOperationSegment: RecordType = .income

    var category: Category?
    
    let amountLabel = UILabel(text: "Amount", alignment: .left)
    let descriptionLabel = UILabel(text: "Description", alignment: .left)
    let dateLabel = UILabel(text: "Date", alignment: .left)
    
    let amountTextField = UITextField(
        defaultText: "0.00",
        background: .lightGray.withAlphaComponent(0.2),
        keyboard: .decimalPad,
        placeholder: "Enter your value"
    )
    let descriptionTextField = UITextField(
        background: .clear,
        keyboard: .default,
        placeholder: "For example: Bought in the store"
    )
    let dateTextField: UITextField = {
        let todayString = dateFormatter.string(from: Date())

        let textField  = UITextField(
            defaultText: "Today \(todayString)",
            background: .clear,
            keyboard: .numberPad,
            placeholder: "Select date"
        )
        
        textField.inputView = datePicker
        textField.inputAccessoryView = createToolbar()
        textField.tintColor = .clear
        
        return textField
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    static let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.timeZone = NSTimeZone.local
        picker.locale = Locale(identifier: "en_EU_POSIX")
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    static let defaultCategory = "Select category"
    let categoryButton = UIButton(
        name: defaultCategory,
        background: .clear,
        textColor: .black
    )
    let saveButton = UIButton(
        name: "Save operation",
        background: .black,
        textColor: .white
    )
    
    // Инициализация переменных homeVC и operationID
    public required init(segmentIndex: Int) {
        addOperationTypeSwitcher.selectedSegmentIndex = segmentIndex
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Add a new operation"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(operationID: Int) {
        self.operationID = operationID
        super.init(nibName: nil, bundle: nil)
        
        // Передаем значения операции из редактируемой ячейки
        guard let record = Records.shared.getRecord(for: operationID) else { return }
        category = record.category
        amountTextField.text = "\(record.amount)"
        descriptionTextField.text = record.descriptionText
        categoryButton.setTitle(record.category.name, for: .normal)
        dateTextField.text = Self.dateFormatter.string(from: record.date)
        addOperationSegment = record.type
        addOperationTypeSwitcher.selectedSegmentIndex = addOperationSegment == .income ? 0 : 1
        
        self.title = "Editing operation"
        saveButton.setTitle("Edit operation", for: .normal)
        addOperationTypeSwitcher.isHidden = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector (printZalupa)
        )
    }
    
    @objc func printZalupa() {
        print("printZalupa")
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.delegate = self
        dateTextField.delegate = self
        
        setTargets() // Таргеты для кнопок
        setAddOpStack() // Стаки для объектов на экране
    }
}
