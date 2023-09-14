//
//  AccountsTransferVC.swift
//  CoinTail
//
//  Created by Eugene on 06.09.23.
//

import UIKit


final class AccountsTransferVC: BasicVC {
    
    var accountsArr = Accounts.shared.accounts
        
    let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view.alpha = 0
        
        return view
    }()

    let transferAmountLabel = UILabel(text: "Amount".localized(), alignment: .left)

    let transferAmountTF = UITextField(
        defaultText: "0",
        background: .lightGray.withAlphaComponent(0.2),
        keyboard: .numberPad,
        placeholder: "Enter your amount".localized()
    )
    
    let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.down")
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var selectedButton = UIButton()
    
    static let firstAccountText = "First Account"
    static let secondAccountText = "Second Account"

    let selectFirstAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray.withAlphaComponent(0.2)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle(firstAccountText, for: .normal)
        
        return button
    }()
    
    let selectSecondAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray.withAlphaComponent(0.2)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle(secondAccountText, for: .normal)
        
        return button
    }()
    
    let saveTransferButton = UIButton(
        name: "Save Transfer".localized(),
        background: .black,
        textColor: .white
    )
    
    let accountsCV: UICollectionView = {
        let accountsLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: accountsLayout)
        cv.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 5
        cv.register(AccountCell.self, forCellWithReuseIdentifier: AccountCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transfer between accounts".localized()
        
        accountsCV.delegate = self
        transferAmountTF.delegate = self
        
        accountsCV.dataSource = self

        transferSubviews()
        accountsTransferTargets()
    }
    
}
