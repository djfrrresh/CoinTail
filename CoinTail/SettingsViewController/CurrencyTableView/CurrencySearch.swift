//
//  CurrencySearch.swift
//  CoinTail
//
//  Created by Eugene on 28.12.22.
//

import UIKit


extension CurrencyTableVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = allCurrencies.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        self.currencyTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.currencyTableView.reloadData()
    }
    
}
