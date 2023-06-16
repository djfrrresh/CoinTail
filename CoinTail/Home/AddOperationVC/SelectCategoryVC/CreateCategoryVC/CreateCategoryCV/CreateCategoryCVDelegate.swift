//
//  CreateCategoryCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension CreateCategoryVC: UICollectionViewDelegate {
    
    // Действия при нажатии на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryImage = UIImage(systemName: CreateCategoryVC.newImages[indexPath.row]) ?? UIImage(systemName: "house")!
        
        createCategoryCV.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
    }
    
}
