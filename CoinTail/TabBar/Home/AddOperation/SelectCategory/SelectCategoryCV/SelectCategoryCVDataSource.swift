//
//  SelectCategoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension SelectCategoryVC: UICollectionViewDataSource {

    // Количество категорий
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.shared.categories[addOperationVCSegment]?.count ?? 0
    }
    
    // Ячейки заполняются
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelectCategoryCVCell.id,
            for: indexPath
        ) as? SelectCategoryCVCell else {
            fatalError("Unable to dequeue SelectCategoryCVCell.")
        }
        
        let categoryLabel = Categories.shared.categories[addOperationVCSegment]?[indexPath.row].name ?? "Category".localized()
        let categoryImage = Categories.shared.categories[addOperationVCSegment]?[indexPath.row].image ?? UIImage(systemName: "house")
        let categoryColor = Categories.shared.categories[addOperationVCSegment]?[indexPath.row].color ?? .clear
        
        cell.categoryName.text = categoryLabel
        cell.categoryImage.image = categoryImage
        cell.backView.backgroundColor = categoryColor
        
        return cell
    }
      
}
