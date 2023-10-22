//
//  ContactsCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//


import UIKit


extension AboutAppVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            gmailAction()
        case 1:
            telegramAction()
        default:
            return
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ContactsCell.size()
    }
    
}
