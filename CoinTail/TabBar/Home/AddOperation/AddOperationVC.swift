//
//  AddOperationVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy
import RealmSwift


final class AddOperationVC: PickerVC {
    
    var recordID: ObjectId?
    var categoryID: ObjectId?
    var accountID: ObjectId?
    var isUsingCurrenciesPicker: Bool = true
    
    var operationAmount: String?
    var operationDescription: String?
    var operationDate: Date?
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
            RecordType.income.rawValue.localized(),
            RecordType.expense.rawValue.localized()
        ])
        
        return switcher
    }()
    var addOperationSegment: RecordType = .income
    
    let deleteOperationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "cancelAction")
        button.layer.cornerRadius = 16
        button.setTitle("Delete transaction".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.isHidden = true
        
        return button
    }()
    
    init(operationID: ObjectId) {
        self.recordID = operationID
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Edit transaction".localized()

        guard let record = Records.shared.getRecord(for: operationID) else { return }
        setupUI(with: record)
    }
    
    public required init(segmentIndex: Int) {
        addOperationTypeSwitcher.selectedSegmentIndex = segmentIndex
        addOperationSegment = segmentIndex == 0 ? .income : .expense
        
        super.init(nibName: nil, bundle: nil)

        self.title = "Add a new transaction".localized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        
        addOperationCV.delegate = self
        itemsPickerView.delegate = self
        
        addOperationCV.dataSource = self
        itemsPickerView.dataSource = self
                
        addOperationNavBar()
        addOperationSubviews()
        setTargets()
        setupToolBar()
    }
    
}
