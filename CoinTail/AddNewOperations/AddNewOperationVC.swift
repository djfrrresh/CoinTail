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
    // Вызываем функцию из протокола и делаем всякое
    func sendCategory(category: String) {
        categoryButton.setTitle(category, for: .normal) // Меняет текст выбранной категории в кнопке
    }
    
    // Достаем картинку из категорий
    var categoryImage: String = ""
    func sendCategoryImage(categoryImage: String) {
        self.categoryImage = categoryImage
    }
    
    weak var addNewOpDelegate: AddNewOpSendData?
    
    var expenseCategories = ["Transport", "Glocery", "Cloths", "Gym", "Service", "Subscription", "Health", "Cafe"]
    var expenseImages = ["car.circle", "cart.circle", "tshirt", "figure.walk.circle", "gearshape.circle", "gamecontroller", "heart.circle", "fork.knife.circle"]
    
    var incomeCategories = ["Salary", "Debt repayment", "Side job"]
    var incomeImages = ["dollarsign.circle", "creditcard.circle", "briefcase.circle"]
    
    var categories = [String]()
    var categoryImages = [String]()
    
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
    let dateButton: UIButton = {
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
    
    // Ссылка на HomeViewController, на объекты внутри него
    let homeViewController: HomeViewController
    // Инициализация переменной homeViewController
    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
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
//        self.dateButton.addTarget(self,
//                         action: #selector(createToolbarAction),
//                         for: .touchUpInside)
        
        amountTextField.delegate = self
        
        setStack() // Стаки для объектов на экране
    }
}

// Протокол отправки всех введенных значений операции
protocol AddNewOpSendData: AnyObject {
    func sendCategoryButtonText(categoryText: String)
    func sendCategoryImage(categoryImage: String)
    func sendAmount(amountText: String)
    func sendDescription(descriptionText: String)
    func sendDate(dateText: String)
}
