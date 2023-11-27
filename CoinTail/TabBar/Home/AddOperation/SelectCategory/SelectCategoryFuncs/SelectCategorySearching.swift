//
//  SelectCategorySearching.swift
//  CoinTail
//
//  Created by Eugene on 23.11.23.
//

import UIKit


extension SelectCategoryVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = categories
            isSearching = false
        } else {
            let lowercaseSearchText = searchText.lowercased()
            isSearching = true
            
            filteredData = categories.filter { category in
                let categoryName = category.name.lowercased()
                                
                return categoryName.contains(lowercaseSearchText)
            }
        }
        
        selectCategoryCV.reloadData()
    }
    
}
