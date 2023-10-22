//
//  SelectCategoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


protocol SendCategoryID: AnyObject {
    func sendCategoryData(id: ObjectId)
}

extension SelectCategoryVC: UICollectionViewDataSource {
    
    // Количество категорий
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }

    // Количество подкатегорий
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isParental {
            return 0
        } else {
            let subcategoriesCount = categories[section].subcategories.count
            return subcategoriesCount
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
                
        let subcategoryID = categories[indexPath.section].subcategories[indexPath.row]
        let subcategoryData = Categories.shared.getSubcategory(for: subcategoryID)
        
        guard let image = subcategoryData?.image else { return UICollectionViewCell() }

        let subcategoryLabel = subcategoryData?.name
        let subcategoryImage = UIImage(systemName: image)
        let subcategoryColor = UIColor(hex: subcategoryData?.color ?? "FFFFFF")

        cell.categoryLabel.text = subcategoryLabel
        cell.categoryImage.image = subcategoryImage
        cell.backImageView.backgroundColor = subcategoryColor
        
        return cell
    }
      
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SelectCategoryCell.id,
            for: indexPath
        ) as? SelectCategoryCell else {
            return UICollectionViewCell()
        }
        
        headerView.tag = indexPath.section
        headerView.headerSettings()
        
        let categoryLabel = categories[indexPath.section].name
        let categoryColor = categories[indexPath.section].color
        
        guard let image = categories[indexPath.section].image else { return UICollectionViewCell() }
        
        headerView.categoryLabel.text = categoryLabel
        headerView.categoryImage.image = UIImage(systemName: image)
        headerView.backImageView.backgroundColor = UIColor(hex: categoryColor ?? "FFFFFF")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        headerView.addGestureRecognizer(tapGestureRecognizer)

        return headerView
    }
    
    @objc func tapDetected(_ sender: UITapGestureRecognizer) {
        guard let headerViewID = sender.view?.tag else { return }
        let categoryID = categories[headerViewID].id
        
        categoryDelegate?.sendCategoryData(id: categoryID)
                
        // TODO: переделать закрытие поп-ап и навигационного контроллера после редизайна
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
}
