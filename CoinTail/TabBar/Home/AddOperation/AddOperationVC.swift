//
//  AddOperationVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
    
    static var accounts: [AccountClass] {
        get {
            return RealmService.shared.accountsArr
        }
    }
    let favouriteStringCurrencies: [String] = Currencies.shared.currenciesToChoose()
    let accountNames = Accounts.shared.getAccountNames(from: accounts)
    
    let defaultDescription = "Add a comment to your transaction".localized()
    
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
            RecordType.expense.rawValue.localized(),
            RecordType.income.rawValue.localized()
        ])
        
        return switcher
    }()
    var addOperationSegment: RecordType = .expense
    
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
        addOperationSegment = segmentIndex == 0 ? .expense : .income
        
        super.init(nibName: nil, bundle: nil)

        self.title = "Add a new transaction".localized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
                
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
