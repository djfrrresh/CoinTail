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
    var filteredData = [Currency]()
    var isSearching: Bool = false
    
    let currencySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Type USD or Dollar for search".localized()
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        return searchBar
    }()
    
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
        
        self.title = "Currencies".localized()
        
        currenciesCV.delegate = self
        currencySearchBar.delegate = self
        
        currenciesCV.dataSource = self
        
        currenciesSubviews()
    }
    
}
