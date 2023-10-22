//
//  CreateCategoryActions.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


protocol AddNewCategory: AnyObject {
    func sendNewCategoryData(category: CategoryClass)
}

protocol AddNewSubcategory: AnyObject {
    func sendNewSubcategoryData(subcategory: SubcategoryClass)
}

extension CreateCategoryVC {
    
    // Проверка на наличие текста и выбранной иконки, вывод ошибки или закрытие PopVC
    @objc func addNewItemAction(_ sender: UIButton) {
        if (categoryNameTF.text?.isEmpty == true) {
            errorAnimate()
        } else {
            guard let categoryText = categoryNameTF.text else { return }

            let isSubcategory = parentalCategoryButton.titleLabel?.text == CreateCategoryVC.defaultParentalCategoryText ? false : true
            
            if isSubcategory {
                guard let parentalCategoryText = parentalCategoryButton.titleLabel?.text else { return }
                
                guard let parentalCategoryID = Categories.shared.getCategoryID(for: parentalCategoryText, type: addOperationVCSegment) else { return }

                let subcategory = SubcategoryClass()
                subcategory.name = categoryText
                subcategory.color = selectedColor?.toHex() ?? UIColor.white.toHex()
                subcategory.image = selectedCategoryImage
                subcategory.parentCategory = parentalCategoryID
                                
                Categories.shared.addSubcategoryToCategory(
                    for: parentalCategoryID,
                    to: addOperationVCSegment,
                    subcategoryID: subcategory.id
                )
                
                addNewSubcategoryDelegate?.sendNewSubcategoryData(subcategory: subcategory)
            } else {
                let category = CategoryClass()
                category.name = categoryText
                category.color = selectedColor?.toHex() ?? UIColor.white.toHex()
                category.image = selectedCategoryImage
                
                addNewCategoryDelegate?.sendNewCategoryData(category: category)
            }
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    // Переход в VC с выбором цвета
    @objc func didTapSelectColor() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        
        present(colorPickerVC, animated: true)
    }
    
    @objc func goToSelectCategoryVC() {
        let vc = SelectCategoryVC(segmentTitle: segmentTitle ?? "Expense", isParental: true)
        vc.categoryDelegate = self
        
        present(vc, animated: true)
    }

}
