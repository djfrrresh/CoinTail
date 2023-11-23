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
            
            if isSubcategory {
                let subcategory = SubcategoryClass()
                subcategory.name = categoryName
                subcategory.color = randomColor.toHex()
                subcategory.image = categoryIcon
                
                guard let categoryID = strongSelf.categoryID else { return }
                subcategory.parentCategory = categoryID

                //TODO: объединить обе функции ниже
                Categories.shared.addSubcategoryToCategory(
                    for: categoryID,
                    subcategoryID: subcategory.id
                )

                Categories.shared.addNewSubcategory(subcategory)
            } else {
                let category = CategoryClass()
                category.name = categoryName
                category.color = randomColor.toHex()
                category.image = categoryIcon
                category.type = strongSelf.addOperationVCSegment.rawValue

                Categories.shared.addNewCategory(category)
            }

            strongSelf.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func goToSelectCategoryVC() {
        guard let segmentTitle = segmentTitle else { return }
        
        let vc = SelectCategoryVC(segmentTitle: segmentTitle, isParental: false, categoryID: nil)
        vc.categoryDelegate = self
        
        present(vc, animated: true)
    }

}
