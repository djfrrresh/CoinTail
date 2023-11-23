//
//  SelectCategoryCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension SelectCategoryVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isParental {
            let vc = SelectCategoryVC(segmentTitle: operationSegmentType.rawValue, isParental: false, categoryID: categories[indexPath.row].id)
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let categoryID = categories[indexPath.row].id
    
            categoryDelegate?.sendCategoryData(id: categoryID)
    
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SelectCategoryCell.size()
    }
    
}
