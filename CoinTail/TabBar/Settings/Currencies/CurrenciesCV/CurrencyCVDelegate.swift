//
//  CurrencyCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 13.09.23.
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
