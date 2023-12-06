//
//  AddBudgetVC.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit
import RealmSwift


final class AddBudgetVC: PickerVC {
    
    var budgetCategoryID: ObjectId?
    var budgetID: ObjectId?
    var selectedCurrency: String = Currencies.shared.selectedCurrency.currency {
        didSet {
            let indexPathToUpdate = IndexPath(item: 1, section: 0)
            
            updateCell(at: indexPathToUpdate, text: selectedCurrency)
        }
    }
    var budgetTimePeriod: String = "Month".localized() {
        didSet {
            let indexPathToUpdate = IndexPath(item: 3, section: 0)
            
            updateCell(at: indexPathToUpdate, text: budgetTimePeriod)
        }
    }
    var budgetCategory: String? {
        didSet {
            guard let budgetCategory = budgetCategory else { return }
            let indexPathToUpdate = IndexPath(item: 2, section: 0)
            
            updateCell(at: indexPathToUpdate, text: budgetCategory)
        }
    }
    var budgetAmount: String?
    
    static let favouriteStringCurrencies: [String] = Currencies.shared.currenciesToChoose()
    
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
        cv.isScrollEnabled = false

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
        
        self.title = "Add a new budget".localized()
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
        
        itemsPickerView.dataSource = self
        addBudgetCV.dataSource = self
        
        itemsPickerView.delegate = self
        addBudgetCV.delegate = self
        
        addBudgetSubviews()
        addBudgetNavBar()
        setupToolBar()
    }
    
}
