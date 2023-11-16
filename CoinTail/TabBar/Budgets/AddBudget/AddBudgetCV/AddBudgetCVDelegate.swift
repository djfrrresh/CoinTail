//
//  AddBudgetCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit


extension AddBudgetVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            toolBar.isHidden = false
            currenciesPickerView.isHidden = false
            
            selectedCurrency = favouriteStringCurrencies[0]
        case 2:
            goToSelectCategoryVC()
        case 3:
            goToBudgetPeriodVC()
        default:
            return
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AddBudgetCell.size()
    }
    
}
