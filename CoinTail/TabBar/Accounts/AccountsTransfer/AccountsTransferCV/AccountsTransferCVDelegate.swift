//
//  AccountsTransferCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 07.09.23.
//

import UIKit


extension AccountsTransferVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedButton.setTitle(accountsArr[indexPath.row].name, for: .normal)
        removeTransparentView()
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AccountCell.size()
    }

}
