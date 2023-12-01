//
//  AddAccountCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 31.10.23.
//

import UIKit


extension AddAccountVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            showPickerView()
            
            selectedCurrency = AddAccountVC.favouriteStringCurrencies[0]
        default:
            return
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AddAccountCell.size()
    }
    
}
