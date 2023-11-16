//
//  CreateCategoryActions.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


extension CreateCategoryVC {
    
    // Проверка на наличие текста и выбранной иконки, вывод ошибки или закрытие PopVC
    @objc func createCategoryAction() {
        let categoryName = categoryName ?? ""
        let categoryIcon = categoryIcon ?? ""
        let mainCategoryName = mainCategoryName ?? ""

        let isSubcategory = isToggleOn
        let randomColor = UIColor.randomColor()
        
        categoryValidation(name: categoryName, icon: categoryIcon, mainCategory: mainCategoryName, isSubcategory: isSubcategory) { [weak self] categoryName, categoryIcon in
            guard let strongSelf = self else { return }
            
            //TODO: subcategory
            if isSubcategory {
//                let subcategory = SubcategoryClass()
//                subcategory.name = categoryName
//                subcategory.color = randomColor.toHex()
//                subcategory.image = categoryIcon
//                subcategory.parentCategory = categoryID
//
//                Categories.shared.addSubcategoryToCategory(
//                    for: categoryID,
//                    to: strongSelf.addOperationVCSegment,
//                    subcategoryID: subcategory.id
//                )
//
//                Categories.shared.addNewSubcategory(subcategory)
            } else {
                let category = CategoryClass()
                category.name = categoryName
                category.color = randomColor.toHex()
                category.image = categoryIcon

                Categories.shared.addNewCategory(category, type: strongSelf.addOperationVCSegment)
            }

            strongSelf.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func goToSelectCategoryVC() {
        let vc = SelectCategoryVC(segmentTitle: segmentTitle ?? "Expense", isParental: true)
        vc.categoryDelegate = self
        
        present(vc, animated: true)
    }

}
