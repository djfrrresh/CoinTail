//
//  AddAccountCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 31.10.23.
//

import UIKit


extension AddAccountVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            toolBar.isHidden = false
            currenciesPickerView.isHidden = false
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AddAccountCell.size()
    }
    
}
