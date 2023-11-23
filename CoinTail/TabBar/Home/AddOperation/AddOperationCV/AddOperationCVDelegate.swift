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
                toolBar.isHidden = false
                addOperationPickerView.isHidden = false
                
                selectedAccount = accountNames[0]
            }
        case 3:
            isUsingCurrenciesPicker = true
            toolBar.isHidden = false
            addOperationPickerView.isHidden = false
            
            selectedCurrency = AddOperationVC.favouriteStringCurrencies[0]
        default:
            return
        }
        addOperationPickerView.selectRow(0, inComponent: 0, animated: false)
        addOperationPickerView.reloadAllComponents()
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
