//
//  CurrenciesSearching.swift
//  CoinTail
//
//  Created by Eugene on 14.09.23.
//

import UIKit


extension CurrenciesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // Если строка поиска пуста, отобразить все доступные валюты
            filteredData = Currency.allCases
            isSearching = false
        } else {
            let lowercaseSearchText = searchText.lowercased()
            isSearching = true
            
            filteredData = Currency.allCases.filter { currency in
                let currencyName = currency.rawValue.lowercased()
                                
                return currencyName.contains(lowercaseSearchText)
            }
        }
        
        currenciesCV.reloadData()
    }
    
}
