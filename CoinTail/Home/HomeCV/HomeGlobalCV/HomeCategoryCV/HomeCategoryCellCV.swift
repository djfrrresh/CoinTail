//
//  HomeCategoryCVCell.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


extension HomeCategoryCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArrCellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCVCell.id,
            for: indexPath
        ) as? CategoryCVCell else {
            fatalError("Unable to dequeue DateCVCell.")
        }
        
        let categoryLabel: String?
        let categoryColor: UIColor?
        
        categoryLabel = categoriesArrCellData[indexPath.row].name
        categoryColor = categoriesArrCellData[indexPath.row].color
        
        cell.categoryName.text = categoryLabel
        cell.backView.backgroundColor = categoryColor
        
        return cell
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CategoryCVCell.size(data: categoriesArrCellData[indexPath.row].name)
    }
    
}
