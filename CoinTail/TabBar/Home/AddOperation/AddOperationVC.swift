//
//  AddOperationVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy
import RealmSwift


class AddOperationVC: BasicVC {
    
    var recordID: ObjectId?
    var categoryID: ObjectId?
    var accountID: ObjectId?
    var operationAmount: String?
    var isUsingCurrenciesPicker: Bool = true
    var operationDate: Date?
    var operationDescription: String?
    
    var operationCategory: String? {
        didSet {
            guard let operationCategory = operationCategory else { return }
            let indexPathToUpdate = IndexPath(item: 1, section: 0)
            
            updateCell(at: indexPathToUpdate, text: operationCategory)
        }
    }
    var selectedAccount: String? {
        didSet {
            guard let selectedAccount = selectedAccount, let account = Accounts.shared.getAccount(for: selectedAccount) else { return }
            let indexPathToUpdate = IndexPath(item: 2, section: 0)
            
            updateCell(at: indexPathToUpdate, text: selectedAccount)
            accountID = account.id
        }
    }
    var selectedCurrency: String = Currencies.shared.selectedCurrency.currency {
        didSet {
            let indexPathToUpdate = IndexPath(item: 3, section: 0)
            
            updateCell(at: indexPathToUpdate, text: selectedCurrency)
        }
    }
    
    static let favouriteStringCurrencies: [String] = Currencies.shared.currenciesToChoose()
    static let accounts = RealmService.shared.accountsArr
    let accountNames = Accounts.shared.getAccountNames(from: accounts)
    
    let addOperationCV: UICollectionView = {
        let addOperationLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0

            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: addOperationLayout)
        cv.backgroundColor = .clear
        cv.register(AddOperationCell.self, forCellWithReuseIdentifier: AddOperationCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.isScrollEnabled = false
        
        return cv
    }()
        
    let addOperationTypeSwitcher: UISegmentedControl = {
        let switcher = UISegmentedControl(items: [
            RecordType.income.rawValue,
            RecordType.expense.rawValue
        ])
        
        return switcher
    }()
    var addOperationSegment: RecordType = .income
    
    let deleteOperationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "cancelAction")
        button.layer.cornerRadius = 16
        button.setTitle("Delete operation".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.isHidden = true
        
        return button
    }()
    
    let addOperationPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.isHidden = true
        
        return picker
    }()
    
    let toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.isHidden = true
        toolbar.sizeToFit()
        toolbar.tintColor = .systemBlue

        return toolbar
    }()
    
    public required init(segmentIndex: Int) {
        addOperationTypeSwitcher.selectedSegmentIndex = segmentIndex
        addOperationSegment = segmentIndex == 0 ? .income : .expense
        
        super.init(nibName: nil, bundle: nil)

        self.title = "Add a new transaction".localized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(operationID: ObjectId) {
        self.recordID = operationID
        
        super.init(nibName: nil, bundle: nil)
        
        guard let record = Records.shared.getRecord(for: operationID) else { return }
        
        self.title = "Edit transaction".localized()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(removeOperation)
        )
        setupUI(with: record)
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOperationCV.delegate = self
        addOperationPickerView.delegate = self
        
        addOperationCV.dataSource = self
        addOperationPickerView.dataSource = self
                
        addOperationNavBar()
        addOperationSubviews()
        setTargets()
        setupToolBar()
    }
    
}
