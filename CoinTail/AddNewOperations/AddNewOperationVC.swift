//
//  AddNewOperationVC.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy


// Указываем название протокола из AddNewOperationPopVC
class AddNewOperationVC: UIViewController, СategorySendTextImage {
    
    var operationID: Int?
    
    // Ссылка на HomeViewController, на объекты внутри него
    let homeViewController: HomeViewController
    // Инициализация переменных homeViewController и operationID
    // Если написать HomeViewController().funcName(), то я создам новый объект / метод
    public required init(homeViewController: HomeViewController, operationID: Int? = nil, segmentIndex: Int) {
        self.homeViewController = homeViewController
        self.operationID = operationID
        super.init(nibName: nil, bundle: nil)
        switchButton.selectedSegmentIndex = segmentIndex
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var addNewOpDelegate: AddNewOpSendData?
        
    // CATEGORIES
    var expenseCategories = ["Transport", "Glocery", "Cloths", "Gym", "Service", "Subscription", "Health", "Cafe"]
    var expenseImages = ["car.circle", "cart.circle", "tshirt", "figure.walk.circle", "gearshape.circle", "gamecontroller", "heart.circle", "fork.knife.circle"]
    
    var incomeCategories = ["Salary", "Debt repayment", "Side job"]
    var incomeImages = ["dollarsign.circle", "creditcard.circle", "briefcase.circle"]
    
    var categories = [String]()
    var categoryImages = [String]()
    
    // Достаем картинку из категорий
    var categoryImage: String = ""
    func sendCategoryImage(categoryImage: String) {
        self.categoryImage = categoryImage
    }
    
    // SWITCH
    let switchButton: UISegmentedControl = {
        let switcher = UISegmentedControl(items: [RecordType.income.rawValue, RecordType.expense.rawValue])
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
//    let amountNumLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
    
    // TEXTFIELDS
    let amountTextField: UITextField = {
        let textField = UITextField(defaultText: "0.0")
        return textField
    }()
    let descriptionTextField: UITextField = {
        let textField = UITextField(defaultText: "")
        return textField
    }()
    
    let dateTextField: UITextField = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let toDay = Date()

        let textField  = UITextField(defaultText: "Today \(dateFormatter.string(from: toDay))")
        return textField
    }()
    
    // BUTTONS
    static let defaultCategory = "Select category"
    let categoryButton: UIButton = {
        let button = UIButton(name: defaultCategory)
        return button
    }()
    let saveButton: UIButton = {
        let button = UIButton(name: "Save operation")
        return button
    }()
//    let dateButton: UIButton = {
//        let button = UIButton()
//        return button
//    }()
    
    // DATE
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
//        picker.timeZone = NSTimeZone.local
        picker.locale = Locale(identifier: "en_EU_POSIX")
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        
        return picker
    }()
            
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.backgroundColor = .white.withAlphaComponent(1)

        self.navigationController?.navigationBar.tintColor = .black
        
        self.saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        self.categoryButton.addTarget(self, action: #selector(categoryButtonAction), for: .touchUpInside)
        self.switchButton.addTarget(self, action: #selector(switchButtonAction), for: .valueChanged)
//        self.dateButton.addTarget(self, action: #selector(createToolbarAction), for: .touchUpInside)
        
        amountTextField.delegate = self
        
        setStack() // Стаки для объектов на экране
    }
}

// Протокол отправки всех введенных значений операции
protocol AddNewOpSendData: AnyObject {
    func sendNewOperation(id: Int?, amount: Double, description: String, category: String, image: String, date: Date, switcher: String, type: RecordType)
}
