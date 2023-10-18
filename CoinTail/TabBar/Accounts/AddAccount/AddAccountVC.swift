//
//  AddAccountVC.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit
import RealmSwift


final class AddAccountVC: BasicVC {
    
    var accountID: ObjectId?
    
    let accountAmountLabel = UILabel(text: "Initial amount".localized(), alignment: .left)
    let accountNameLabel = UILabel(text: "Account name".localized(), alignment: .left)
    var currency: Currency = Currencies.shared.selectedCurrency
    var currentIndex = 0
    
    let accountAmountTF = UITextField(
        defaultText: "0",
        background: .lightGray.withAlphaComponent(0.2),
        keyboard: .numberPad,
        placeholder: "Enter amount".localized()
    )
    let accountNameTF = UITextField(
        defaultText: "",
        background: .lightGray.withAlphaComponent(0.2),
        keyboard: .default,
        placeholder: "For example: Cash".localized()
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
    
    init(accountID: ObjectId) {
        self.accountID = accountID
        
        super.init(nibName: nil, bundle: nil)

        // Передаем значения бюджета из редактируемой ячейки
        guard let account = Accounts.shared.getAccount(for: accountID) else { return }
        
        accountAmountTF.text = "\(account.startBalance)"
        accountNameTF.text = account.name
        saveAccountButton.setTitle("Edit Account".localized(), for: .normal)
        currencyButton.setTitle("\(account.currency)", for: .normal)

        self.title = "Editing Account".localized()

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
        accountNameTF.delegate = self
        
        setAddAccountStack()
    }
    
}
