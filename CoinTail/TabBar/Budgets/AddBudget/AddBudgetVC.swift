//
//  AddBudgetVC.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit
import RealmSwift


class AddBudgetVC: BasicVC {
    
    var budgetCategoryID: ObjectId?
    var budgetID: ObjectId?
    var selectedCurrency: String = Currencies.shared.selectedCurrency.currency
    var budgetAmount: String?
    var budgetCategory: String?
    var budgetTimePeriod: String = "Month"
    
    static let favouriteCurrencies: [FavouriteCurrencyClass] = Currencies.shared.currenciesToChoose()
    let favouriteStringCurrencies: [String] = Currencies.shared.extractCurrencyStrings(from: favouriteCurrencies)
    
    let deleteBudgetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "cancelAction")
        button.layer.cornerRadius = 16
        button.setTitle("Delete budget".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.isHidden = true
        
        return button
    }()
    
    let currenciesPickerView: UIPickerView = {
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
    
    let addBudgetCV: UICollectionView = {
        let addAccountLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0

            return layout
        }()

        let cv = UICollectionView(frame: .zero, collectionViewLayout: addAccountLayout)
        cv.backgroundColor = .clear
        cv.register(AddBudgetCell.self, forCellWithReuseIdentifier: AddBudgetCell.id)

        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.delaysContentTouches = true

        return cv
    }()
    
    init(budgetID: ObjectId) {
        self.budgetID = budgetID
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Edit budget".localized()
        
        guard let budget = Budgets.shared.getBudget(for: budgetID) else { return }
        setupUI(with: budget)
    }
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addBudgetTargets()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add a new budget".localized()

        currenciesPickerView.dataSource = self
        addBudgetCV.dataSource = self
        
        currenciesPickerView.delegate = self
        addBudgetCV.delegate = self
        
        addBudgetSubviews()
        addBudgetNavBar()
        setupToolBar()
    }
    
}
