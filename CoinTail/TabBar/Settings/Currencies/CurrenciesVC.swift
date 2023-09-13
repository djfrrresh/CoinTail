//
//  CurrenciesVC.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit


final class CurrenciesVC: BasicVC, GetCurrencyIndex {
    
    func sendCurrency(_ currency: Currency) {
        Currencies.shared.toggleFavouriteCurrency(currency)
        
        currenciesCV.reloadData()
    }
    
    var favouriteCurrencies: [Currency] { Currencies.shared.favouriteCurrencies }
    var selectedCurrency: Currency { Currencies.shared.selectedCurrency }
    
    let currenciesCV: UICollectionView = {
        let currenciesLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: currenciesLayout)
        cv.backgroundColor = .clear
        cv.register(CurrencyCell.self, forCellWithReuseIdentifier: CurrencyCell.id)
        cv.register(CurrencyCVHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CurrencyCVHeader.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.delaysContentTouches = true
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select currency"
        
        currenciesCV.delegate = self
        
        currenciesCV.dataSource = self
        
        currenciesSubviews()
    }
    
}
