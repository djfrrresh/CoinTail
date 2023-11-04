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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // Количество подкатегорий
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    // Ячейки заполняются
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelectCategoryCell.id,
            for: indexPath
        ) as? SelectCategoryCell else {
            return UICollectionViewCell()
        }
                
        let categoryID = categories[indexPath.row].id
        let categoryData = Categories.shared.getCategory(for: categoryID)
        
        guard let image = categoryData?.image else { return cell }

        let categoryLabel = categoryData?.name
        let categoryImage = UIImage(systemName: image)
        let categoryColor = UIColor(hex: categoryData?.color ?? "FFFFFF")

        cell.categoryLabel.text = categoryLabel
        cell.categoryImage.image = categoryImage
        
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
