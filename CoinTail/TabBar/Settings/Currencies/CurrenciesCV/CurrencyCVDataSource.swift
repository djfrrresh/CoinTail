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
            return Currencies.shared.currencyNames.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CurrencyCell.id,
            for: indexPath
        ) as? CurrencyCell else {
            fatalError("Unable to dequeue CurrencyCell.")
        }
        
        var currencyCode, currencyName: String
        var array: [Currency]
        
        let currency: Currency
        
        switch indexPath.section {
        case 0:
            currencyCode = "\(favouriteCurrencies[indexPath.row])"
            currencyName = favouriteCurrencies[indexPath.row].name
            currency = favouriteCurrencies[indexPath.row]
            array = favouriteCurrencies
        case 1:
            currency = Currencies.shared.currencyNames[indexPath.row]
            currencyCode = Currencies.shared.currencyCodes[indexPath.row]
            currencyName = currency.name
            array = Currencies.shared.currencyNames
        default:
            return cell
        }
        
        cell.currencyDelegate = self
        cell.checkmarkImageView.isHidden = array[indexPath.row] != selectedCurrency
        cell.currencyCodeLabel.text = currencyCode
        cell.currencyNameLabel.text = currencyName
        cell.currency = currency
        cell.isFavourite(currency: currency, array: favouriteCurrencies)
        
        return cell
    }
    
    // Header в виде даты окончания действия бюджета
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CurrencyCVHeader.id,
            for: indexPath
        ) as? CurrencyCVHeader else {
            fatalError("Unable to dequeue CurrencyCVHeader.")
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
