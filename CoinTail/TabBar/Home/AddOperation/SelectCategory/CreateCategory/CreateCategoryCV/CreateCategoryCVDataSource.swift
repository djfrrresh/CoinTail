//
//  CreateCategoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension CreateCategoryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
//            if accountID != nil {
//                cell.accountNameTF.text = accountName
//            }
            
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
            
            cell.categoryIconTF.isHidden = false
            cell.menuLabel.isHidden = false
            cell.categoryNameTF.isHidden = true
            cell.emojiLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            cell.onOffToggle.isHidden = true
            cell.parentalCategoryLabel.isHidden = true
            cell.isSeparatorLineHidden(false)
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
