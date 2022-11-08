//
//  AddNewOperationTV.swift
//  CoinTail
//
//  Created by Eugene on 27.10.22.
//

import UIKit
import EasyPeasy


extension AddNewOperationPopVC: UICollectionViewDelegate, UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.id, for: indexPath) as! CustomCollectionCell
        cell.configure(label: categories[indexPath.row], image: categoryImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoryDelegate?.sendCategory(category: self.categories[indexPath.row]) // Передаем выбранную категорию
        categoryDelegate?.sendCategoryImage(categoryImage: self.categoryImages[indexPath.row]) // Передаем выбранную картинку категории
                        
        self.dismiss(animated: true, completion: nil)
    }
        
}

// Протокол с функциями, по которому передаем данные из 1 контроллера в другой
protocol СategorySendTextImage: AnyObject {
    func sendCategory(category: String)
    func sendCategoryImage(categoryImage: String)
}
