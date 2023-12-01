//
//  AccountsVC.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


class AccountsVC: BasicVC {
            
    var accounts: [AccountClass] {
        get {
            return RealmService.shared.accountsArr
        }
    }
    
    let emptyAccountsView = UIView()

    let monocleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "monocleEmoji")
        
        return imageView
    }()
    
    let noAccountsLabel: UILabel = {
        let label = UILabel()
        label.text = "You have no accounts added".localized()
        label.textColor = UIColor(named: "black")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    let accountsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Here you can add different money storage methods, such as cards, cash or a bank deposit".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }()
    
    let addAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitle("Add an account".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
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
        cv.layer.cornerRadius = 12
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        
        return cv
    }()
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationTitle(title: "Accounts".localized(), large: true)
        isAccountEmpty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        accountsCV.dataSource = self
        
        accountsCV.delegate = self
        
        accountsSubviews()
        emptyAccountsSubviews()
        accountButtonTargets()
    }
    
}
