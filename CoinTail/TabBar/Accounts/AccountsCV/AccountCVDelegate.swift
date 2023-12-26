//
//  AccountCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit
import RealmSwift


extension AccountsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let accountData = accounts[indexPath.row]

        self.navigationItem.rightBarButtonItem?.target = nil

        let vc = AddAccountVC(accountID: accountData.id)
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
            
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AccountCell.size()
    }

}