//
//  AddAccountVC.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


final class AddAccountVC: BasicVC {
    
    var accountID: Int?
    
    let accountAmountLabel = UILabel(text: "Amount".localized(), alignment: .left)
    let accountNameLabel = UILabel(text: "Account name".localized(), alignment: .left)
    var currency: Currency = Currencies.shared.selectedCurrency
    var currentIndex = 0
    
    let accountAmountTF = UITextField(
        defaultText: "0",
        background: .lightGray.withAlphaComponent(0.2),
        keyboard: .numberPad,
        placeholder: "Enter your amount".localized()
    )
    let accountNameTF = UITextField(
        defaultText: "",
        background: .lightGray.withAlphaComponent(0.2),
        keyboard: .default,
        placeholder: "Enter account name".localized()
    )
    
    let currencyButton = UIButton(
        name: "\(Currencies.shared.selectedCurrency)",
        background: .clear,
        textColor: .black
    )
    let saveAccountButton = UIButton(
        name: "Save Account".localized(),
        background: .black,
        textColor: .white
    )
    
    init(accountID: Int) {
        self.accountID = accountID
        
        super.init(nibName: nil, bundle: nil)

        // Передаем значения бюджета из редактируемой ячейки
        guard let account = Accounts.shared.getAccount(for: accountID) else { return }
        
        accountAmountTF.text = "\(account.balance)"
        accountNameTF.text = account.name
        saveAccountButton.setTitle("Edit Account".localized(), for: .normal)
        currencyButton.setTitle("\(account.currency)", for: .normal)

        self.title = "Editing account".localized()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector (removeAccount)
        )
    }
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Add new Account".localized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addAccountTargets()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        accountAmountTF.delegate = self
        
        setAddAccountStack()
    }
    
}
