//
//  AccountsTransferCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 07.09.23.
//

import UIKit


extension AccountsTransferVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0, 1:
            saveTransferButton.isHidden = true
            accountsPickerView.isHidden = false
            toolBar.isHidden = false
            
            selectedRowIndex = indexPath.row
        default:
            return
        }
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return TransferCell.size()
    }

}
