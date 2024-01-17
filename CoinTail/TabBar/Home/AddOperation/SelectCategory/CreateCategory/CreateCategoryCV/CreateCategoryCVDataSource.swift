//
//  CreateCategoryCVDataSource.swift
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


extension CreateCategoryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryID != nil ? 2 : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = createCategoryCV.dequeueReusableCell(
            withReuseIdentifier: CreateCategoryCell.id,
            for: indexPath
        ) as? CreateCategoryCell else {
            return UICollectionViewCell()
        }
        
        cell.createCategoryCellDelegate = self
        
        switch indexPath.row {
        case 0:
            cell.cornerRadiusTop(radius: 12)
            cell.categoryNameTF.placeholder = "Category name".localized()
            if categoryID != nil {
                cell.categoryNameTF.text = categoryName
            }
            
            cell.categoryIconTF.isHidden = true
            cell.menuLabel.isHidden = true
            cell.categoryNameTF.isHidden = false
            cell.emojiLabel.isHidden = true
            cell.chevronImageView.isHidden = true
            cell.onOffToggle.isHidden = true
            cell.parentalCategoryLabel.isHidden = true
            cell.isSeparatorLineHidden(false)
        case 1:
            cell.menuLabel.text = "Icon".localized()
            if categoryID != nil {
                cell.categoryIconTF.text = categoryIcon
            }
            
            cell.categoryIconTF.isHidden = false
            cell.menuLabel.isHidden = false
            cell.categoryNameTF.isHidden = true
            cell.emojiLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            cell.onOffToggle.isHidden = true
            cell.parentalCategoryLabel.isHidden = true
            if categoryID != nil {
                cell.isSeparatorLineHidden(true)
                cell.cornerRadiusBottom(radius: 12)
            } else {
                cell.isSeparatorLineHidden(false)
            }
        case 2:
            cell.menuLabel.text = "Make as subcategory".localized()
            
            cell.categoryIconTF.isHidden = true
            cell.menuLabel.isHidden = false
            cell.categoryNameTF.isHidden = true
            cell.emojiLabel.isHidden = true
            cell.chevronImageView.isHidden = true
            cell.onOffToggle.isHidden = false
            cell.parentalCategoryLabel.isHidden = true
            cell.isSeparatorLineHidden(false)
        case 3:
            cell.cornerRadiusBottom(radius: 12)
            cell.menuLabel.text = "Main category".localized()
            cell.menuLabel.textColor = UIColor(named: "secondaryTextColor")
            cell.parentalCategoryLabel.text = mainCategoryName

            cell.categoryIconTF.isHidden = true
            cell.menuLabel.isHidden = false
            cell.categoryNameTF.isHidden = true
            cell.emojiLabel.isHidden = true
            cell.chevronImageView.isHidden = false
            cell.onOffToggle.isHidden = true
            cell.parentalCategoryLabel.isHidden = false
            cell.isSeparatorLineHidden(true)
        default:
            return cell
        }
        
        return cell
    }

}
