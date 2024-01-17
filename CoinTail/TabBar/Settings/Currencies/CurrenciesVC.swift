//
//  CurrenciesVC.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
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


final class CurrenciesVC: BasicVC {
    
    let currenciesClass = Currencies.shared

    var favouriteCurrencies: [FavouriteCurrencyClass] {
        return RealmService.shared.favouriteCurrenciesArr
    }
    var selectedCurrency: SelectedCurrencyClass = Currencies.shared.selectedCurrency {
        didSet {
            currenciesCV.reloadData()
        }
    }
    var filteredData = [Currency]()
    var isSearching: Bool = false
    
    let currencySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Type USD or Dollar for search".localized()
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        return searchBar
    }()
    
    let currenciesCV: UICollectionView = {
        let currenciesLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
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
