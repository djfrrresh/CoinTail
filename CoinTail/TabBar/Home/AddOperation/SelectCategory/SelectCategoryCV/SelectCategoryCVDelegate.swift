//
//  SelectCategoryCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


protocol SendСategory: AnyObject {
    func sendCategoryData(category: Category)
}

extension SelectCategoryVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // При нажатии на категорию закрывается контроллер и она передается в кнопку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let categoryLabel = Categories.shared.categories[addOperationVCSegment]?[indexPath.row].name ?? "Category".localized()
        let categoryImage = Categories.shared.categories[addOperationVCSegment]?[indexPath.row].image ?? UIImage(named: "house")
        let categoryColor = Categories.shared.categories[addOperationVCSegment]?[indexPath.row].color ?? .clear
        
        categoryDelegate?.sendCategoryData(
            category: Category(
                name: categoryLabel,
                color: categoryColor,
                image: categoryImage,
                type: addOperationVCSegment
            )
        )
                        
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SelectCategoryCell.size()
    }
    
}
