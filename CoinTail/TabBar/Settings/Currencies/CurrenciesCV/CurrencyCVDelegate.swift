//
//  CurrencyCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 13.09.23.
//

import UIKit


extension CurrenciesVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CurrencyCell.size()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var currency: String = ""
        
        switch indexPath.section {
        case 0:
            currency = "\(favouriteCurrencies[indexPath.row].currency)"
        case 1:
            if isSearching {
                currency = "\(filteredData[indexPath.row])"
            } else {
                currency =  "\(Currencies.shared.currencyNames[indexPath.row])"
            }
        default:
            return
        }
        
        let selectedCurrency = SelectedCurrencyClass()
        selectedCurrency.currency = currency
        
        currenciesClass.selectedCurrency = selectedCurrency

        currenciesCV.reloadData()
    }
    
}
