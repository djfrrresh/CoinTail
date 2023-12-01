//
//  AddOperationCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.11.23.
//

import UIKit


extension AddOperationVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            goToSelectCategoryVC()
        case 2:
            if !accountNames.isEmpty {
                isUsingCurrenciesPicker = false
                showPickerView()
                
                selectedAccount = accountNames[0]
            } else {
                errorAlert("You don't have any accounts to choose from".localized())
            }
        case 3:
            isUsingCurrenciesPicker = true
            showPickerView()
            
            selectedCurrency = AddOperationVC.favouriteStringCurrencies[0]
        default:
            return
        }
        
        itemsPickerView.selectRow(0, inComponent: 0, animated: false)
        itemsPickerView.reloadAllComponents()
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return AddOperationCell.size()
        case 1:
            return AddOperationCell.descriptionCellSize()
        default:
            return CGSize()
        }
    }
    
}
