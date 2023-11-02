//
//  BudgetPeriodCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit


extension BudgetPeriodVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return periodsMenu.count
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RegularityCell.id,
            for: indexPath
        ) as? RegularityCell else {
            return UICollectionViewCell()
        }
        
        cell.menuLabel.text = periodsMenu[indexPath.row]
        cell.checkmarkImageView.isHidden = periodsMenu[indexPath.row] != selectedPeriod
        
        switch indexPath.row {
        case 0:
            cell.cornerRadiusTop(radius: 12)
            
            cell.isSeparatorLineHidden(false)
        case 1:
            cell.cornerRadiusBottom(radius: 12)

            cell.isSeparatorLineHidden(true)
        default:
            return cell
        }
                    
        return cell
    }
    
}
