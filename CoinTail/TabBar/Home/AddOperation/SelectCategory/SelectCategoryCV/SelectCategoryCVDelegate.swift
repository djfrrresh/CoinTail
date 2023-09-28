//
//  SelectCategoryCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


protocol SendSubcategoryID: AnyObject {
    func sendSubcategoryData(id: Int)
}

extension SelectCategoryVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // При нажатии на категорию закрывается контроллер и она передается в кнопку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let subcategoryID = Categories.shared.categories[addOperationVCSegment]?[indexPath.section].subcategories?[indexPath.row] else { return }
        
        subcategoryDelegate?.sendSubcategoryData(id: subcategoryID)
                        
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SelectCategoryCell.size()
    }
    
}
