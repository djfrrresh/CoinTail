//
//  AccountCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AccountsVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AccountCell.id,
            for: indexPath
        ) as? AccountCell else {
            return UICollectionViewCell()
        }
                
        let accountData: AccountClass = accounts[indexPath.row]
        var totalAmountForCash: Double = accountData.startBalance

        //TODO: api
//        if let account = Accounts.shared.getAccount(for: accountData.id) {
//            Records.shared.calculateTotalBalance(for: account.id) { totalAmount in
//                if let totalAmount = totalAmount {
//                    totalAmountForCash += totalAmount
//
//                    Accounts.shared.editBalance(for: account.id, replacingBalance: totalAmountForCash)
//
//                    let formattedAmount = String(format: "%.2f", totalAmountForCash)
//                    cell.amountLabel.text = "\(formattedAmount) \(accountData.currency)"
//                } else {
//                    print("Failed to calculate total amount.")
//                    cell.amountLabel.text = "\(0.00) \(accountData.currency)"
//                }
//            }
//        }
        
        cell.nameLabel.text = "\(accountData.name)"
        
        let isLastRow = self.collectionView(collectionView, numberOfItemsInSection: indexPath.section) - 1 == indexPath.row
        cell.isSeparatorLineHidden(isLastRow)
        
        // Динамическое округление ячеек
        if indexPath.item == 0 && isLastRow {
            cell.roundCorners(.allCorners, radius: 12)
        } else if isLastRow {
            cell.roundCorners(bottomLeft: 12, bottomRight: 12)
        } else if indexPath.row == 0 {
            cell.roundCorners(topLeft: 12, topRight: 12)
        } else {
            cell.roundCorners(.allCorners, radius: 0)
        }
        
        return cell
    }
    
}
