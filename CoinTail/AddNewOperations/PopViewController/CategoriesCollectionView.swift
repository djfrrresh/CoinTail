//
//  AddNewOperationTV.swift
//  CoinTail
//
//  Created by Eugene on 27.10.22.
//

import UIKit
import EasyPeasy


extension AddNewOperationPopVC: UICollectionViewDelegate, UICollectionViewDataSource, AddNewCategory {
    
    func sendNewCategoryData(name: String, image: String) {
        print("\(name) \(image)")
        self.newCategoryName = name
        self.newCategoryImage = image
    }
    
    func addItemToEnd() {
        self.categories.append(newCategoryName!) // Добавление в массив новых элементов
        self.categoryImages.append(newCategoryImage!)
        self.collectionView?.insertItems(at: [IndexPath(row: self.categories.count - 1, section: 0)]) // + 1 элемент
    }

    // Количество категорий всего
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    // Ячейки заполняются
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.id, for: indexPath) as! CustomCollectionCell
        cell.configure(label: categories[indexPath.row], image: categoryImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoryDelegate?.sendCategory(category: categories[indexPath.row]) // Передаем выбранную категорию
        categoryDelegate?.sendCategoryImage(categoryImage: categoryImages[indexPath.row]) // Передаем выбранную картинку категории
                        
        navigationController?.popViewController(animated: true)
    }
      
}

// Протокол с функциями, по которому передаем данные из 1 контроллера в другой
protocol СategorySendTextImage: AnyObject {
    func sendCategory(category: String)
    func sendCategoryImage(categoryImage: String)
}
