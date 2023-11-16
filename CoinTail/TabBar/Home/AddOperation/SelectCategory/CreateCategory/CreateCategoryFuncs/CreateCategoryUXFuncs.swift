//
//  CreateCategoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


extension CreateCategoryVC: SendCategoryID, CreateCategoryCellDelegate {
    
    func cell(didUpdateCategoryName name: String?) {
        categoryName = name
    }
    
    func cell(didUpdateCategoryIcon icon: String?) {
        categoryIcon = icon
    }
    
    func cell(didUpdateOnOffToggle isOn: Bool) {
        isToggleOn = isOn
        
        if let cell = createCategoryCV.cellForItem(at: IndexPath(row: 3, section: 0)) as? CreateCategoryCell {
            cell.menuLabel.textColor = isToggleOn ? .black : UIColor(named: "secondaryTextColor")
        }
    }

    func sendCategoryData(id: ObjectId) {
        categoryID = id
    }
    
    func categoryValidation(name: String, icon: String, mainCategory: String, isSubcategory: Bool, completion: ((String, String) -> Void)? = nil) {
        let missingName = name == ""
        let missingIcon = icon == ""
        let missingMainCategory = mainCategory == ""

        if missingName {
            errorAlert("Category name is missing".localized())
        } else if missingIcon {
            errorAlert("Category icon not selected".localized())
        } else if isSubcategory && missingMainCategory {
            errorAlert("No parent category selected".localized())
        } else {
//            guard let categoryID = self.categoryID else { return }
            
            completion?(name, icon)
        }
    }
    
}
