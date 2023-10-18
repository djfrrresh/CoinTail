//
//  AccountsVC.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


class AccountsVC: BasicVC {
    
    weak var accountDelegate: SendAccountID? // Передает счет
    
    var isSelected: Bool = false
    
    var accounts = [AccountClass]() {
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
    let historyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.turn.up.backward.badge.clock"), for: .normal)
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
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Accounts".localized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(isSelected: Bool) {
        super.init(nibName: nil, bundle: nil)
        
        self.isSelected = isSelected
        transferButton.isHidden = true
        historyButton.isHidden = true
        
        self.title = "Account selection".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sortAccounts()
        accountsNavBar()
        accountButtonTargets()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountsCV.dataSource = self
        
        accountsCV.delegate = self
        
        accountsSubviews()
    }
    
}
