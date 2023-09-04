//
//  AccountCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AccountsVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let accountData = accounts[indexPath.row]

        self.navigationItem.rightBarButtonItem?.target = nil

        let vc = AddAccountVC(accountID: accountData.id)
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar

        navigationController?.pushViewController(vc, animated: true)
    }

}
