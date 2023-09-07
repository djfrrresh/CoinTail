//
//  AccountsVC.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


class AccountsVC: BasicVC {
    
    var accounts = [Account]() {
        didSet {
            accountsCV.reloadData()
        }
    }
    
    let transferButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.right.and.arrow.down.left.rectangle"), for: .normal)
        button.backgroundColor = .lightGray.withAlphaComponent(0.5)
        button.tintColor = .darkGray
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    let accountsCV: UICollectionView = {
        let accountsLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: accountsLayout)
        cv.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0) // Отступ сверху
        cv.backgroundColor = .clear
        cv.register(AccountCell.self, forCellWithReuseIdentifier: AccountCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        accountsNavBar()
        sortAccounts()
        accountButtonTargets()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Accounts".localized()

        accountsCV.dataSource = self
        
        accountsCV.delegate = self
        
        accountsSubviews()
        
        Accounts.shared.addNewAccount(Account(id: 0, name: "Cash", amount: 200))
        Accounts.shared.addNewAccount(Account(id: 1, name: "Card 1", amount: 1000))
        Accounts.shared.addNewAccount(Account(id: 2, name: "Card 2", amount: 50))
    }
    
}
