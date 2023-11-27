//
//  SelectCategoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


extension SelectCategoryVC: UICollectionViewDataSource {

    // Количество категорий
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        } else {
            return categories.count
        }
    }
    
    // Ячейки заполняются
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelectCategoryCell.id,
            for: indexPath
        ) as? SelectCategoryCell else {
            return UICollectionViewCell()
        }
        
        var categoryData: CategoryProtocol
        
        if isSearching {
            categoryData = filteredData[indexPath.row]
        } else {
            categoryData = categories[indexPath.row]
        }

        cell.categoryLabel.text = categoryData.name
        cell.categoryIcon.text = categoryData.image
        cell.isEditingCategory(isEditingCategory)
        cell.chevronImageView.isHidden = !isParental
        
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
