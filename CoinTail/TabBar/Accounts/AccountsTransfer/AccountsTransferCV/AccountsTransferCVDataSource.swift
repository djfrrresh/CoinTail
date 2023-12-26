//
//  AccountsTransferCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 07.09.23.
//

import UIKit


extension AccountsTransferVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transferMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TransferCell.id,
            for: indexPath
        ) as? TransferCell else {
            return UICollectionViewCell()
        }

        cell.menuLabel.text = transferMenu[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.accountNameLabel.text = accountNameFrom
            
            cell.amountTextField.isHidden = true
            cell.accountNameLabel.isHidden = false
            cell.isSeparatorLineHidden(false)
        case 1:
            cell.accountNameLabel.text = accountNameTo

            cell.amountTextField.isHidden = true
            cell.accountNameLabel.isHidden = false
            cell.isSeparatorLineHidden(false)
        case 2:
            cell.transferCellDelegate = self
            cell.amountTextField.isHidden = false
            cell.accountNameLabel.isHidden = true
            cell.isSeparatorLineHidden(true)
        default:
            return cell
        }
        
        return cell
    }
    
}
