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

extension CreateCategoryVC {
    
    // Проверка на наличие текста и выбранной иконки, вывод ошибки или закрытие PopVC
    @objc func addNewItemAction(_ sender: UIButton) {
        if (categoryTF.text?.isEmpty == true) {
            errorAnimate()
        } else {
            addNewCategoryDelegate?.sendNewCategoryData(category: Category(
                name: categoryTF.text ?? "new category",
                color: selectedColor ?? .white,
                image: selectedCategoryImage)
            )
            dismiss(animated: true, completion: nil)
        }
    }
    
    // Переход в VC с выбором цвета
    @objc func didTapSelectColor() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }

}
