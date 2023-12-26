//
//  CreateCategoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


extension CreateCategoryVC: SendCategoryID, CreateCategoryCellDelegate {
    
    func sendCategoryData(id: ObjectId) {
        categoryID = id
        
        guard let category = Categories.shared.getCategory(for: id) else { return }
                
        mainCategoryName = category.name
    }
    
    func cell(didUpdateCategoryName name: String?) {
        categoryName = name
    }
    
    func cell(didUpdateCategoryIcon icon: String?) {
        categoryIcon = icon
    }
    
    func cell(didUpdateOnOffToggle isOn: Bool) {
        isToggleOn = isOn
        
        if !isOn {
            mainCategoryName = ""
        }
        
        if let cell = createCategoryCV.cellForItem(at: IndexPath(row: 3, section: 0)) as? CreateCategoryCell {
            cell.menuLabel.textColor = isToggleOn ? .black : UIColor(named: "secondaryTextColor")
        }
    }
    
    func createCategoryTargets() {
        deleteCategoryButton.addTarget(self, action: #selector(removeCategory), for: .touchUpInside)
    }
    
    func categoryValidation(name: String, icon: String, mainCategory: String, isSubcategory: Bool, completion: ((String, String) -> Void)? = nil) {
        let missingName = name == ""
        let missingIcon = icon == ""
        let missingMainCategory = mainCategory == ""

        if missingName {
            infoAlert("Category name is missing".localized())
        } else if missingIcon {
            infoAlert("Category icon not selected".localized())
        } else if isSubcategory && missingMainCategory {
            infoAlert("No parent category selected".localized())
        }
//        else if isSubcategory {
//            if AppSettings.shared.premium?.isPremiumActive ?? false {
            //TODO: premium
//                infoAlert("Creating subcategories is only available with a Premium subscription".localized())

//                return
//            }
//        }
        else {
            completion?(name, icon)
        }
    }
    
}
