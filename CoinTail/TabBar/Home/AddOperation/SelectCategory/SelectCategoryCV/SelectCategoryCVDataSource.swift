//
//  SelectCategoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
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
