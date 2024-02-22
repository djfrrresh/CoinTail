//
//  AccountsVC.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit
import RealmSwift


protocol SendAccount: AnyObject {
    func sendAccountData(id: ObjectId)
}

final class AccountsVC: BasicVC {
            
    var accounts: [AccountClass] = RealmService.shared.accountsArr
    
    weak var accountDelegate: SendAccount?
    
    var isSelecting: Bool = false
    
    static let noAccountsText = "You have no accounts added"
    static let accountsDescriptionText = "Here you can add different money storage methods, such as cards, cash or a bank deposit"
    
    let noAccountsLabel: UILabel = getNoDataLabel(text: noAccountsText)
    let accountsDescriptionLabel: UILabel = getDataDescriptionLabel(text: accountsDescriptionText)
    let accountsEmojiLabel: UILabel = getDataEmojiLabel("🧐")
    let addAccountButton: UIButton = getAddDataButton(text: "Add an account")

    let transferButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitle("Transfer money".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
    let historyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "secondaryAction")
        button.layer.cornerRadius = 16
        button.setTitle("Transfer history".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "primaryAction"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
    
    let accountsCV: UICollectionView = {
        let accountsLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: accountsLayout)
        cv.contentInset = .init(top: 32, left: 0, bottom: 0, right: 0) // Отступ сверху
        cv.backgroundColor = .clear
        cv.register(AccountCell.self, forCellWithReuseIdentifier: AccountCell.id)
        cv.cornerRadiusBottom(radius: 12)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
    
    public required init(isSelecting: Bool = false) {
        self.isSelecting = isSelecting
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accounts = RealmService.shared.accountsArr
        accountsCV.reloadData()

        customNavBar.customButton.addTarget(self, action: #selector(goToAddAccountVC), for: .touchUpInside)
        customNavBar.titleLabel.text = "Accounts".localized()
                
        accountsCV.dataSource = self
        
        navigationController?.delegate = self
        accountsCV.delegate = self
        
        accountsSubviews()
        accountButtonTargets()
        emptyDataSubviews(
            dataView: accountsEmojiLabel,
            noDataLabel: noAccountsLabel,
            dataDescriptionLabel: accountsDescriptionLabel,
            addDataButton: addAccountButton
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Использовать этот способ + dispatch asyncAfter если стоит async на методах
        accounts = RealmService.shared.accountsArr
        accountsCV.reloadData()
        
        isAccountEmpty()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isSelecting {
            navigationController?.navigationBar.isHidden = true
        } else {
            navigationController?.navigationBar.isHidden = false
        }
    }
    
}
