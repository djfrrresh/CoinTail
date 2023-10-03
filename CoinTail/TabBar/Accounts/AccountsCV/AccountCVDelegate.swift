//
//  AccountCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


protocol SendAccountID: AnyObject {
    func sendAccountData(accountID: Int)
}

extension AccountsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let accountData = accounts[indexPath.row]

        self.navigationItem.rightBarButtonItem?.target = nil

        // Если мы зашли с экрана создания операции, то при нажатии на счет он передается в кнопку, иначе переходим на экран редактирования счета
        if isSelected {
            accountDelegate?.sendAccountData(accountID: accountData.id)
            
            self.navigationController?.popViewController(animated: true)
        } else {
            let vc = AddAccountVC(accountID: accountData.id)
            vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AccountCell.size()
    }

}
