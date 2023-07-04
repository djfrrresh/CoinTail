//
//  AddBudgetVC.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit


class AddBudgetVC: BasicVC {
        
    let budgetNameLabel = UILabel(text: "Budget name", alignment: .left)
    let budgetAmountLabel = UILabel(text: "Amount", alignment: .left)
    let budgetPeriodLabel = UILabel(text: "Select period", alignment: .left)
    
    let budgetNameTF = UITextField(
        background: .clear,
        keyboard: .default,
        placeholder: "Enter the name of the budget"
    )
    let budgetAmountTF = UITextField(
        background: .lightGray.withAlphaComponent(0.2),
        keyboard: .numberPad,
        placeholder: "Enter your value"
    )
    
    static let defaultCategory = "Select categories"
    let categoriesButton = UIButton(
        name: defaultCategory,
        background: .clear,
        textColor: .black
    )
    let saveBudgetButton = UIButton(
        name: "Save Budget",
        background: .black,
        textColor: .white
    )
    
    let periodSwitcher: UISegmentedControl = {
        let switcher = UISegmentedControl(items: [
            "Week",
            "Month",
            "3 months"
        ])
        switcher.selectedSegmentIndex = 0
        return switcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add new Budget"
        
        setAddBudgetStack()
        addBudgetActions()
    }
    
}
