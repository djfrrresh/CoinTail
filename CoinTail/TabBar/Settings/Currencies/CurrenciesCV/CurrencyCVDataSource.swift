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
        var array: [Currency]
        
        let currency: Currency
        
        //TODO: corner radius, divider
        switch indexPath.section {
        case 0:
            currencyCode = "\(favouriteCurrencies[indexPath.row])"
            currencyName = favouriteCurrencies[indexPath.row].name
            currency = favouriteCurrencies[indexPath.row]
            array = favouriteCurrencies
        case 1:
            if isSearching {
                currency = filteredData[indexPath.row]
                currencyCode = "\(filteredData[indexPath.row])"
                currencyName = currency.name
                array = filteredData
            } else {
                currency = Currencies.shared.currencyNames[indexPath.row]
                currencyCode = Currencies.shared.currencyCodes[indexPath.row]
                currencyName = currency.name
                array = Currencies.shared.currencyNames
            }
        default:
            return cell
        }
        
        cell.currencyDelegate = self
        cell.checkmarkImageView.isHidden = array[indexPath.row] != selectedCurrency
        cell.currencyCodeLabel.text = currencyCode
        cell.currencyNameLabel.text = currencyName
        cell.currency = currency
        cell.isFavourite(currency: currency, array: favouriteCurrencies)
        
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
            text = !favouriteCurrencies.isEmpty ? "Favourites" : ""
        case 1:
            text = "All currencies"
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
