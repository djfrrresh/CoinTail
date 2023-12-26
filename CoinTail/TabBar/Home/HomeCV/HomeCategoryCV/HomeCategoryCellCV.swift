//
//  HomeCategoryCVCell.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


protocol SendCategoryCellDelegate: AnyObject {
    func sendCategory(category: CategoryClass)
}

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
            return UICollectionViewCell()
        }
        
        let categoryLabel = categoriesArrCellData[indexPath.row].name
        let categoryColor: UIColor?
        
        switch segmentType {
        case .expense, .income:
            categoryColor = UIColor(hex: categoriesArrCellData[indexPath.row].color ?? "FFFFFF")
        case .allOperations:
            let categoryType = categoriesArrCellData[indexPath.row].type
            
            categoryColor = categoryType == RecordType.income.rawValue ? UIColor(named: "income") : UIColor(named: "expense")
        }
                
        cell.categoryName.text = categoryLabel
        cell.contentView.backgroundColor = categoryColor
        cell.isXmark = self.category != nil
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category: CategoryClass = categoriesArrCellData[indexPath.row]
        
        sendCategoryDelegate?.sendCategory(category: category)
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CategoryCVCell.size(data: categoriesArrCellData[indexPath.row].name, isXmark: category != nil)
    }
    
}