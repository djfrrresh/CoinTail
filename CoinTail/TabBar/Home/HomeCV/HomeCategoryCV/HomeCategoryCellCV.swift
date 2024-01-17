//
//  HomeCategoryCVCell.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
            
            categoryColor = categoryType == RecordType.expense.rawValue ? UIColor(named: "expense") : UIColor(named: "income")
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
        return CategoryCVCell.size(
            data: categoriesArrCellData[indexPath.row].name,
            isXmark: category != nil
        )
    }
    
}
