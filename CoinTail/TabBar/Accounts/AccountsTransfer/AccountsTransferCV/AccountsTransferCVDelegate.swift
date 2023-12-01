//
//  AccountsTransferCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 07.09.23.
//

import UIKit


extension AccountsTransferVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !accountNames.isEmpty {
            switch indexPath.row {
            case 0:
                showPickerView()
                
                selectedRowIndex = indexPath.row
                accountNameFrom = accountNames[0]
            case 1:
                showPickerView()
                
                selectedRowIndex = indexPath.row
                accountNameTo = accountNames[0]
            default:
                return
            }
        }
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return TransferCell.size()
    }

}
