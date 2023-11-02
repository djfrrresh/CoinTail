//
//  AddBudgetCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit


extension AddBudgetVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddBudgetCell.id,
            for: indexPath
        ) as? AddBudgetCell else {
            return UICollectionViewCell()
        }
        
//        cell.addBudgetCellDelegate = self
                        
        switch indexPath.row {
        case 0:
            cell.cornerRadiusTop(radius: 12)
            cell.budgetAmountTF.placeholder = "Amount".localized()
            if budgetID != nil {
                cell.budgetAmountTF.text = budgetAmount
            }

            cell.budgetAmountTF.isHidden = false
            cell.menuLabel.isHidden = true
            cell.subMenuLabel.isHidden = true
            cell.chevronImageView.isHidden = true
            cell.isSeparatorLineHidden(false)
        case 1:
            cell.menuLabel.text = "Currency".localized()
            cell.subMenuLabel.text = selectedCurrency

            cell.budgetAmountTF.isHidden = true
            cell.menuLabel.isHidden = false
            cell.subMenuLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            cell.isSeparatorLineHidden(false)
        case 2:
            cell.menuLabel.text = "Category".localized()
            cell.subMenuLabel.text = budgetCategory

            cell.budgetAmountTF.isHidden = true
            cell.menuLabel.isHidden = false
            cell.subMenuLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            cell.isSeparatorLineHidden(false)
        case 3:
            cell.cornerRadiusBottom(radius: 12)
            cell.menuLabel.text = "Time period".localized()
            cell.subMenuLabel.text = budgetTimePeriod

            cell.budgetAmountTF.isHidden = true
            cell.menuLabel.isHidden = false
            cell.subMenuLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            cell.isSeparatorLineHidden(true)
        default:
            return cell
        }
                    
        return cell
    }
    
}
