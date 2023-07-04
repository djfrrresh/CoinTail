//
//  SelectCategoryCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


protocol SendСategoryData: AnyObject {
    func sendCategoryData(category: Category)
}

extension SelectCategoryVC: UICollectionViewDelegate {
    
    // При нажатии на категорию закрывается контроллер и она передается в кнопку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let categoryLabel = Categories.shared.categories[addOperationVCSegment]?[indexPath.row].name ?? "Category"
        let categoryImage = Categories.shared.categories[addOperationVCSegment]?[indexPath.row].image ?? UIImage(named: "house")!
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
    
}
