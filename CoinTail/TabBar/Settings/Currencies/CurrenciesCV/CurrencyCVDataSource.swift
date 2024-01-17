//
//  CurrencyCVDataSource.swift
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


extension CurrenciesVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return favouriteCurrencies.count
        case 1:
            if isSearching {
                return filteredData.count
            } else {
                return Currencies.shared.currencyNames.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CurrencyCell.id,
            for: indexPath
        ) as? CurrencyCell else {
            return UICollectionViewCell()
        }
        
        var currencyCode, currencyName: String
        var currenciesArray: [String]
        
        let currency: String
        let favouriteCurrenciesString = currenciesClass.extractCurrencyStrings(from: favouriteCurrencies)

        switch indexPath.section {
        case 0:
            currency = favouriteCurrenciesString[indexPath.row]
            currencyCode = currency
            currencyName = currenciesClass.getCurrencyName(for: currency).localized()
            currenciesArray = favouriteCurrenciesString
        case 1:
            if isSearching {
                let filteredCurrenciesString = currenciesClass.extractCurrencyStrings(from: filteredData)

                currency = "\(filteredData[indexPath.row])"
                currencyCode = currency
                currencyName = filteredData[indexPath.row].rawValue.localized()
                currenciesArray = filteredCurrenciesString
            } else {
                let currenciesString = currenciesClass.extractCurrencyStrings(from: currenciesClass.currencyNames)

                currency = currenciesClass.currencyCodes[indexPath.row]
                currencyCode = currency
                currencyName = currenciesClass.currencyNames[indexPath.row].rawValue.localized()
                currenciesArray = currenciesString
            }
        default:
            return cell
        }
        
        cell.checkmarkImageView.isHidden = currenciesArray[indexPath.row] != selectedCurrency.currency
        cell.currencyCodeLabel.text = currencyCode
        cell.currencyNameLabel.text = currencyName
        cell.currency = currency
        cell.isFavourite(currency: currency, array: favouriteCurrenciesString)
        cell.currenciesCV = currenciesCV
        
        let isLastRow = self.collectionView(collectionView, numberOfItemsInSection: indexPath.section) - 1 == indexPath.row
        cell.isSeparatorLineHidden(isLastRow)
        
        // Динамическое округление ячеек
        if indexPath.item == 0 && isLastRow {
            cell.roundCorners(.allCorners, radius: 12)
        } else if isLastRow {
            cell.roundCorners(bottomLeft: 12, bottomRight: 12)
        } else if indexPath.row == 0 {
            cell.roundCorners(topLeft: 12, topRight: 12)
        } else {
            cell.roundCorners(.allCorners, radius: 0)
        }
        
        return cell
    }
    
    // Header в виде даты окончания действия бюджета
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CurrencyCVHeader.id,
            for: indexPath
        ) as? CurrencyCVHeader else {
            return UICollectionViewCell()
        }
        
        var text: String
        
        switch indexPath.section {
        case 0:
            text = !favouriteCurrencies.isEmpty ? "Featured currencies".localized() : ""
        case 1:
            text = "All currencies".localized()
        default:
            text = ""
        }
        
        headerView.favouretesLabel.text = text

        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 32)
    }
    
}
