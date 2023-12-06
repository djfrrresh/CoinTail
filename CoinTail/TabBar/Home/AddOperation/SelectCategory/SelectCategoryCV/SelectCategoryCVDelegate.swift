//
//  SelectCategoryCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension SelectCategoryVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var categoryData: CategoryProtocol
        
        if isSearching {
            categoryData = filteredData[indexPath.row]
        } else {
            categoryData = categories[indexPath.row]
        }
        
        if isEditingCategory {
            let vc = CreateCategoryVC(categoryID: categoryData.id, segmentTitle: operationSegmentType.rawValue)
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            if isParental {
                let vc = SelectCategoryVC(segmentTitle: operationSegmentType.rawValue, isParental: false, categoryID: categoryData.id)
                vc.categoryDelegate = categoryDelegate
                
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let categoryID = categoryData.id
                
                categoryDelegate?.sendCategoryData(id: categoryID)
                
                if let navigationController = navigationController {
                    navigationController.popToViewController(navigationController.viewControllers[1], animated: true)
                } else {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
        
        isSearching = false
        isEditingCategory = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SelectCategoryCell.size()
    }
    
}
