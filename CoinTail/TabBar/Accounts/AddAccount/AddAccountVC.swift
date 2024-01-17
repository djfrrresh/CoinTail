//
//  AddAccountVC.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
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
import RealmSwift


final class AddAccountVC: PickerVC {
        
    var selectedCurrency: String = Currencies.shared.selectedCurrency.currency {
        didSet {
            let indexPathToUpdate = IndexPath(item: 2, section: 0)
            
            updateCell(at: indexPathToUpdate, text: selectedCurrency)
        }
    }
    
    var accountID: ObjectId?
    var accountName: String?
    var accountAmount: String?
    var isAccountMain: Bool = true
    
    let favouriteStringCurrencies: [String] = Currencies.shared.currenciesToChoose()

    let deleteAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "cancelAction")
        button.layer.cornerRadius = 16
        button.setTitle("Delete account".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.isHidden = true
        
        return button
    }()
    
    let addAccountCV: UICollectionView = {
        let addAccountLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0

            return layout
        }()

        let cv = UICollectionView(frame: .zero, collectionViewLayout: addAccountLayout)
        cv.backgroundColor = .clear
        cv.register(AddAccountCell.self, forCellWithReuseIdentifier: AddAccountCell.id)

        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.isScrollEnabled = false

        return cv
    }()
    
    //TODO: переделать сохранение amount и name при удалении 1 символа
    init(accountID: ObjectId) {
        self.accountID = accountID

        super.init(nibName: nil, bundle: nil)

        self.title = "Edit account".localized()
        
        guard let account = Accounts.shared.getAccount(for: accountID) else { return }
        setupUI(with: account)
    }
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Add a new account".localized()
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
        
        navigationController?.navigationBar.isHidden = false
                
        itemsPickerView.dataSource = self
        addAccountCV.dataSource = self

        itemsPickerView.delegate = self
        addAccountCV.delegate = self
        
        addAccountNavBar()
        addAccountSubviews()
        setupToolBar()
    }

}
