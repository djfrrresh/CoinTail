//
//  CurrencyCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 13.09.23.
//

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
        let favouriteCurrenciesString = extractCurrencyStrings(from: favouriteCurrencies)

        switch indexPath.section {
        case 0:
            currency = favouriteCurrenciesString[indexPath.row]
            currencyCode = currency
            currencyName = currenciesClass.getCurrencyName(for: currency)
            currenciesArray = favouriteCurrenciesString
        case 1:
            if isSearching {
                let filteredCurrenciesString = extractCurrencyStrings(from: filteredData)

                currency = "\(filteredData[indexPath.row])"
                currencyCode = currency
                currencyName = filteredData[indexPath.row].rawValue
                currenciesArray = filteredCurrenciesString
            } else {
                let currenciesString = extractCurrencyStrings(from: currenciesClass.currencyNames)

                currency = currenciesClass.currencyCodes[indexPath.row]
                currencyCode = currency
                currencyName = currenciesClass.currencyNames[indexPath.row].rawValue
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
    
    private func extractCurrencyStrings(from currencies: [FavouriteCurrencyClass]) -> [String] {
        return currencies.map { $0.currency }
    }
    private func extractCurrencyStrings(from currencies: [Currency]) -> [String] {
        return currencies.map { "\($0)" }
    }
    
}
