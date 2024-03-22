//
//  HomeVC.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
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
import Charts


final class HomeVC: BasicVC {
    
    var period: DatePeriods = .allTheTime {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
    
    // Операции, записанные в массив по месяцам
    var monthSections = [OperationsDaySection]() {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
    
    // Категории по типам операций
    var categoriesByType: [CategoryClass] = []
    // Выбранная категория
    var categorySort: CategoryClass? {
        didSet {
            homeGlobalCV.reloadData()
        }
    }
        
    var currentStep: Int = 0
    var isLeft: Bool = true
    var categoryIsHidden: Bool = true
    
    // Используется для возврата операций по выбранному типу
    var homeSegment: RecordType = .allOperations
    var segmentIndex: Int = 0
    
    static let noOperationsText = "Start adding your expenses and income"
    static let operationsDescriptionText = "Manage your finances by tracking your expenses and income via different categories"
    
    let noOperationsLabel: UILabel = getNoDataLabel(text: noOperationsText)
    let operationsDescriptionLabel: UILabel = getDataDescriptionLabel(text: operationsDescriptionText)
    let operationsEmojiLabel: UILabel = getDataEmojiLabel("📊")
    let addOperationButton: UIButton = getAddDataButton(text: "Add a transaction")
    
    // Глобальная коллекция, содержащая выбор даты, диаграммы и операции
    let homeGlobalCV: UICollectionView = {
        let globalLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8

            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: globalLayout)
        cv.backgroundColor = .clear
        cv.register(HomeOperationCell.self, forCellWithReuseIdentifier: HomeOperationCell.id)
        cv.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.id)
        cv.register(HomeDateCell.self, forCellWithReuseIdentifier: HomeDateCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleExchangeRatesUpdated), name: Notification.Name("ExchangeRatesUpdated"), object: nil)
        
        customNavBar.subTitleLabel.text = "Balance".localized()
                               
        navigationController?.delegate = self
        homeGlobalCV.delegate = self

        homeGlobalCV.dataSource = self
        
        homeSubviews()
        emptyDataSubviews(
            dataView: operationsEmojiLabel,
            noDataLabel: noOperationsLabel,
            dataDescriptionLabel: operationsDescriptionLabel,
            addDataButton: addOperationButton
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppSettings.shared.setPremiumUnactive() { isPremiumStillActive, activeUntil in
            if !isPremiumStillActive, activeUntil != nil {
                let vc = PremiumAlert(description: "Your premium subscription has expired: you can purchase premium again or continue using the free version".localized(), title: "Premium has expired".localized())
                self.present(vc, animated: true, completion: nil)
            }
        }
                
        period = .allTheTime
        homeGlobalCV.reloadData()

        sortOperations() // Сортировка операций по убыванию по дате
        homeButtonTargets()
        areOperationsEmpty()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    // Удаляем наблюдателя
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("ExchangeRatesUpdated"), object: nil)
    }

}
