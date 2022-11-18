//
//  PopVCCollectionView.swift
//  CoinTail
//
//  Created by Eugene on 18.11.22.
//

import UIKit
import EasyPeasy


extension CustomPopVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Количество ячеек для новых категорий
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newCategoryImages.count
    }
    
    // Ячейки заполняются
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.id, for: indexPath) as! CustomCollectionCell
        cell.categoryImage.image = UIImage(systemName: newCategoryImages[indexPath.row])
        return cell
    }
    
    // Действия при нажатии на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(newCategoryImages[indexPath.row]) tapped")
        self.selectedCategoryImage = newCategoryImages[indexPath.row]
        self.collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
    }

}

protocol AddNewCategory: AnyObject {
    func sendNewCategoryData(name: String, image: String)
}
