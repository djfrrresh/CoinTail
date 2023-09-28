//
//  CreateCategoryActions.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


protocol AddNewCategory: AnyObject {
    func sendNewCategoryData(category: Category)
}
protocol AddNewSubcategory: AnyObject {
    func sendNewSubategoryData(subcategory: Subcategory)
}

extension CreateCategoryVC {
    
    // Проверка на наличие текста и выбранной иконки, вывод ошибки или закрытие PopVC
    @objc func addNewItemAction(_ sender: UIButton) {
        if (categoryTF.text?.isEmpty == true) {
            errorAnimate()
        } else {
            let isSubcategory = parentalCategoryButton.titleLabel?.text == CreateCategoryVC.defaultParentalCategoryText ? false : true
            
            if isSubcategory {
                guard let parentalCategoryText = parentalCategoryButton.titleLabel?.text else { return }
                
                let subcategoryID = Categories.shared.lastSubcategoryID + 1
                let parentalCategoryID = Categories.shared.getCategoryID(for: parentalCategoryText, type: addOperationVCSegment)
                
                addNewSubcategoryDelegate?.sendNewSubategoryData(
                    subcategory: Subcategory(
                        id: subcategoryID,
                        name: categoryTF.text ?? "New subcategory".localized(),
                        color: selectedColor ?? .white,
                        parentCategory: parentalCategoryID
                    )
                )
            } else {
                let categoryID = Categories.shared.lastCategoryID + 1
                
                addNewCategoryDelegate?.sendNewCategoryData(
                    category: Category(
                        id: categoryID,
                        name: categoryTF.text ?? "New category".localized(),
                        color: selectedColor ?? .white,
                        image: selectedCategoryImage
                    )
                )
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
