//
//  BudgetsVC.swift
//  CoinTail
//
//  Created by Eugene on 21.06.23.
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
import EasyPeasy


final class BudgetsVC: BasicVC {
        
    var budgets: [BudgetClass] {
        get {
            return RealmService.shared.budgetsArr
        }
    }
        
    static let noBudgetsText = "You have no budgets set up"
    static let budgetsDescriptionText = "Here you can set up a budgets for different categories and time periods. Control your expenses now"
    
    let noBudgetsLabel: UILabel = getNoDataLabel(text: noBudgetsText)
    let budgetsDescriptionLabel: UILabel = getDataDescriptionLabel(text: budgetsDescriptionText)
    let budgetsEmojiLabel: UILabel = getDataEmojiLabel("🎯")
    let addBudgetButton: UIButton = getAddDataButton(text: "Add a budget")
    
    let budgetCV: UICollectionView = {
        let budgetLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0

            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: budgetLayout)
        cv.backgroundColor = .clear
        cv.contentInset = .init(top: 32, left: 0, bottom: 0, right: 0) // Отступ сверху
        cv.register(BudgetCell.self, forCellWithReuseIdentifier: BudgetCell.id)
        cv.register(BudgetCVHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BudgetCVHeader.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delaysContentTouches = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
        
    override func viewDidLoad() {
        customNavBar.titleLabel.text = "Budgets".localized()
                
        budgetCV.dataSource = self
        
        navigationController?.delegate = self
        budgetCV.delegate = self
        
        budgetSubviews()
        budgetButtonTargets()
        emptyDataSubviews(
            dataView: budgetsEmojiLabel,
            noDataLabel: noBudgetsLabel,
            dataDescriptionLabel: budgetsDescriptionLabel,
            addDataButton: addBudgetButton
        )
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        budgetCV.reloadData()
        
        areBudgetsEmpty()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
}
