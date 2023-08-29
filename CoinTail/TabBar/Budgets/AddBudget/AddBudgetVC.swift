//
//  AddBudgetVC.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit


class AddBudgetVC: BasicVC {
    
    var budgetCategory: Category?
    var budgetID: Int?
            
    let budgetAmountLabel = UILabel(text: "Amount".localized(), alignment: .left)
    let budgetPeriodLabel = UILabel(text: "Select period".localized(), alignment: .left)
    
    let budgetAmountTF = UITextField(
        defaultText: "0",
        background: .lightGray.withAlphaComponent(0.2),
        keyboard: .numberPad,
        placeholder: "Enter your amount".localized()
    )
    
    static let defaultCategory = "Select category".localized()
    let categoryButton = UIButton(
        name: defaultCategory,
        background: .clear,
        textColor: .black
    )
    let saveBudgetButton = UIButton(
        name: "Save Budget".localized(),
        background: .black,
        textColor: .white
    )
    
    let periodSwitcher: UISegmentedControl = {
        let switcher = UISegmentedControl(items: [
            "Week".localized(),
            "Month".localized()
        ])
        switcher.selectedSegmentIndex = 1
        
        return switcher
    }()
    
    init(budgetID: Int) {
        self.budgetID = budgetID
        
        super.init(nibName: nil, bundle: nil)

        // Передаем значения бюджета из редактируемой ячейки
        guard let budget = Budgets.shared.getBudget(for: budgetID) else { return }
        
        budgetCategory = budget.category
        categoryButton.setTitle(budget.category.name, for: .normal)
        budgetAmountTF.text = "\(budget.amount)"
        saveBudgetButton.setTitle("Edit Budget".localized(), for: .normal)
        periodSwitcher.isHidden = true

        self.title = "Editing budget".localized()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector (removeBudget)
        )
    }
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Add new Budget".localized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addBudgetTargets() // Таргеты для кнопок
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        budgetAmountTF.delegate = self
        
        setAddBudgetStack()
    }
    
}
