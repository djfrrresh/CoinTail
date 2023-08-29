//
//  AddOperationUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension AddOperationVC: SendСategoryData {
    
    func sendCategoryData(category: Category) {
        self.category = category
        categoryButton.setTitle(category.name, for: .normal)
    }
    
    // Установка таргетов для кнопок
    func setTargets() {
        saveOperationButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonAction), for: .touchUpInside)
        addOperationTypeSwitcher.addTarget(self, action: #selector(switchButtonAction), for: .valueChanged)
        amountTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // Проверка поля Amount и текста из кнопки категории на наличие данных в них
    func recordValidation(amount: Double, categoryText: String, completion: ((Double, Category) -> Void)? = nil) {
        let missingAmount = abs(amount) == 0
        let missingCategory = categoryText == AddOperationVC.defaultCategory

        if missingAmount {
            errorAlert("Missing value in amount field".localized())
        } else if missingCategory {
            errorAlert("No category selected".localized())
        } else {
            guard let category = self.category else { return }
            completion?(amount, category)
        }
    }
    
}
