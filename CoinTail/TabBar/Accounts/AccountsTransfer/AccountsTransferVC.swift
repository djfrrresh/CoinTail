//
//  AccountsTransferVC.swift
//  CoinTail
//
//  Created by Eugene on 06.09.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit


final class AccountsTransferVC: PickerVC {
    
    static var accounts: [AccountClass] {
        get {
            return RealmService.shared.accountsArr
        }
    }
    var accountNames = Accounts.shared.getAccountNames(from: accounts)

    var selectedRowIndex: Int?
    var transferAmount: String?
    var accountNameFrom: String? {
        didSet {
            guard let accountNameFrom = accountNameFrom else { return }
            let indexPathToUpdate = IndexPath(item: 0, section: 0)
            
            updateCell(at: indexPathToUpdate, text: accountNameFrom)
            showTransferFrom()
        }
    }
    var accountNameTo: String? {
        didSet {
            guard let accountNameTo = accountNameTo else { return }
            let indexPathToUpdate = IndexPath(item: 1, section: 0)
            
            updateCell(at: indexPathToUpdate, text: accountNameTo)
            showTransferTo()
        }
    }
    
    override var isPickerHidden: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.saveTransferButton.layer.opacity = strongSelf.isPickerHidden ? 1 : 0
            }
        }
    }
        
    let transferMenu: [String] = [
        "From".localized(),
        "To".localized(),
        "Amount".localized()
    ]
    
    let transferFromButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "vectorFrom"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        
        return button
    }()
    let transferToButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "vectorTo"), for: .normal)
        button.adjustsImageWhenHighlighted = false

        return button
    }()
    let saveTransferButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitle("Transfer money".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
    
    let transferFromLabel: UILabel = {
        let label = UILabel()
        label.text = "From".localized()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    let transferToLabel: UILabel = {
        let label = UILabel()
        label.text = "To".localized()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    let transferFromAccountNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.isHidden = true
        
        return label
    }()
    let transferToAccountNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.isHidden = true
        
        return label
    }()
    let transferFromAccountBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.isHidden = true
        
        return label
    }()
    let transferToAccountBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.isHidden = true
        
        return label
    }()
    
    let transferCV: UICollectionView = {
        let transferLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: transferLayout)
        cv.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .clear
        cv.register(TransferCell.self, forCellWithReuseIdentifier: TransferCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.isScrollEnabled = false
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.title = "Transfers".localized()
                
        itemsPickerView.delegate = self
        transferCV.delegate = self
        
        itemsPickerView.dataSource = self
        transferCV.dataSource = self

        transferSubviews()
        accountsTransferTargets()
        setupToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
}
