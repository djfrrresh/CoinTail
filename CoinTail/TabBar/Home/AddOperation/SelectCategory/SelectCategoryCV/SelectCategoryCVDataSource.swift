//
//  SelectCategoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


protocol SendCategoryID: AnyObject {
    func sendCategoryData(id: Int)
}

extension SelectCategoryVC: UICollectionViewDataSource {
    
    // Количество категорий
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories[operationSegmentType]?.count ?? 0
    }

    // Количество подкатегорий
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isParental {
            return 0
        } else {
            let subcategoriesCount = categories[operationSegmentType]?[section].subcategories?.count
            return subcategoriesCount ?? 0
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
                
        guard let subcategoryID = categories[operationSegmentType]?[indexPath.section].subcategories?[indexPath.row] else { return cell }
        
        let subcategoryData = Categories.shared.getSubcategory(for: subcategoryID)
        
        let subcategoryLabel = subcategoryData?.name
        let subcategoryImage = subcategoryData?.image
        let subcategoryColor = subcategoryData?.color

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
        
        guard let categoryLabel = categories[operationSegmentType]?[indexPath.section].name,
              let categoryImage = categories[operationSegmentType]?[indexPath.section].image,
              let categoryColor = categories[operationSegmentType]?[indexPath.section].color else { return headerView }
        
        headerView.categoryLabel.text = categoryLabel
        headerView.categoryImage.image = categoryImage
        headerView.backImageView.backgroundColor = categoryColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        headerView.addGestureRecognizer(tapGestureRecognizer)

        return headerView
    }
    
    @objc func tapDetected(_ sender: UITapGestureRecognizer) {
        guard let headerViewID = sender.view?.tag,
              let categoryID = categories[operationSegmentType]?[headerViewID].id else { return }
        
        categoryDelegate?.sendCategoryData(id: categoryID)
                
        // TODO: переделать закрытие поп-ап и навигационного контроллера после редизайна
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
}
